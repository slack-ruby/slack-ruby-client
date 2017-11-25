module Slack
  module Web
    module Faraday
      module Response
        class RaiseError < ::Faraday::Response::Middleware
          def on_complete(env)
            if env.status == 429
              raise Slack::Web::Api::Errors::TooManyRequestsError, env.response
            elsif (body = env.body) && body['ok']
              nil
            else
              raise Slack::Web::Api::Errors::SlackError.new(body['error'], env.response)
            end
          end
        end
      end
    end
  end
end
