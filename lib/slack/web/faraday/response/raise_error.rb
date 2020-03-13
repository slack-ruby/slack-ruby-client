# frozen_string_literal: true
module Slack
  module Web
    module Faraday
      module Response
        class RaiseError < ::Faraday::Response::Middleware
          def on_complete(env)
            raise Slack::Web::Api::Errors::TooManyRequestsError, env.response if env.status == 429
            return unless (body = env.body) && !body['ok']

            error_message =
              body['error'] || body['errors'].map { |message| message['error'] }.join(',')

            error_class = Slack::Web::Api::Errors::ERROR_CLASSES[error_message]
            error_class ||= Slack::Web::Api::Errors::SlackError
            raise error_class.new(error_message, env.response)
          end
        end
      end
    end
  end
end
