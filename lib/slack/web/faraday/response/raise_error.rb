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

            if Slack::Web.config.verbose_errors && body['response_metadata']
              error_message = "#{error_message}; #{body['response_metadata'].to_json}"
            end

            raise Slack::Web::Api::Errors::SlackError.new(error_message, env.response)
          end
        end
      end
    end
  end
end
