# frozen_string_literal: true
module Slack
  module Web
    module Faraday
      module Response
        class RaiseError < ::Faraday::Middleware
          def raise_if_too_many_requests!(env)
            raise Slack::Web::Api::Errors::TooManyRequestsError, env.response if env.status == 429
          end

          def raise_if_response_is_invalid_json!(env)
            return if response_content_type_is_a_string?(env) || env.body.is_a?(Hash)

            raise ::Faraday::ParsingError.new(nil, env.response)
          end

          def response_content_type_is_a_string?(env)
            env.response&.headers&.[]('content-type')&.include?('text/plain') || false
          end

          def should_return?(env)
            body = env.body
            return true unless env.success?
            return true if env.success? && body.is_a?(String) && response_content_type_is_a_string?(env)
            return true if !body || body['ok']

            false
          end

          def on_complete(env)
            raise_if_too_many_requests!(env)
            raise_if_response_is_invalid_json!(env)

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
