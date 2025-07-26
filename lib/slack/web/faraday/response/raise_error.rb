# frozen_string_literal: true
module Slack
  module Web
    module Faraday
      module Response
        class RaiseError < ::Faraday::Middleware
          def on_complete(env)
            raise Slack::Web::Api::Errors::TooManyRequestsError, redact_response(env.response) if env.status == 429

            return unless env.success?

            body = env.body
            return unless body
            return if body['ok']

            error_message = body['error'] || body['errors'].map { |message| message['error'] }.join(',')
            error_class = Slack::Web::Api::Errors::ERROR_CLASSES[error_message]
            error_class ||= Slack::Web::Api::Errors::SlackError
            raise error_class.new(error_message, redact_response(env.response))
          end

          private

          def redact_response(response)
            return response unless response&.env

            redacted_env = response.env.dup

            # redact Authorization header if it exists
            if redacted_env[:request_headers]&.key?('Authorization')
              redacted_env[:request_headers] = redacted_env[:request_headers].dup
              redacted_env[:request_headers]['Authorization'] = '[REDACTED]'
            end

            redacted_response = ::Faraday::Response.new(redacted_env)
            redacted_response.env[:response] = redacted_response
            redacted_response
          end
        end
      end
    end
  end
end
