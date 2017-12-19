module Slack
  module Web
    module Faraday
      module Response
        class RaiseError < ::Faraday::Response::Middleware
          def on_complete(env)
            if env.status == 429
              raise Slack::Web::Api::Errors::TooManyRequestsError, env.response
            elsif (body = env.body) && !body['ok']
              error_message = body['error'] || body['errors'].map { |message| message['error'] }.join(',')
              raise Slack::Web::Api::Errors::SlackError.new(error_message, env.response)
            end
          end
        end
      end
    end
  end
end
