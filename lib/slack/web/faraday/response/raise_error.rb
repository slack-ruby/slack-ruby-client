# frozen_string_literal: true
module Slack
  module Web
    module Faraday
      module Response
        class RaiseError < ::Faraday::Middleware
          def on_complete(env)
            raise Slack::Web::Api::Errors::TooManyRequestsError, env.response if env.status == 429

            if env.body.is_a?(String)
              handle_non_json_response(env)
            else
              handle_json_response(env)
            end
          end

          private

          def handle_non_json_response(env)
            raise Slack::Web::Api::Errors::ServerError.new('request failed!', env.response) unless env.success?
          end

          def handle_json_response(env)
            return unless env.success?

            body = env.body
            return unless body
            return if body['ok']

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
