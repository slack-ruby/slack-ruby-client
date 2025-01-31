# frozen_string_literal: true
module Slack
  module Web
    module Faraday
      module Response
        class RaiseError < ::Faraday::Middleware
          def throw_if_too_many_requests(env)
            raise Slack::Web::Api::Errors::TooManyRequestsError, env.response if env.status == 429
          end

          def throw_if_response_is_invalid_json(env)
            return unless !response_content_type_is_a_string?(env) && !env.body.is_a?(Hash)

            raise ::Faraday::ParsingError.new(nil, env.response)
          end

          def response_content_type_is_a_string?(env)
            env.response&.headers&.[]('content-type')&.include?('text/plain') || false
          end

          def should_return?(env)
            body = env.body
            (env.success? && body.is_a?(String) && response_content_type_is_a_string?(env)) || !body || body['ok']
          end

          def on_complete(env)
            throw_if_too_many_requests(env)
            throw_if_response_is_invalid_json(env)

            return unless env.success?

            body = env.body
            return if should_return?(env)

            error_message = body['error'] || body['errors'].map { |message| message['error'] }.join(',')
            error_class = Slack::Web::Api::Errors::ERROR_CLASSES[error_message]
            error_class ||= Slack::Web::Api::Errors::SlackError
            raise error_class.new(error_message, env.response)
          end
        end
      end
    end
  end
end
