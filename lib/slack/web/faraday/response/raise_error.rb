module Slack
  module Web
    module Faraday
      module Response
        class RaiseError < ::Faraday::Response::Middleware
          def on_complete(env)
            if env.status == 429
              fail Slack::Web::Api::Errors::TooManyRequestsError, env.response
            elsif (body = env.body) && body['ok']
              return
            else
              fail Slack::Web::Api::Errors::SlackError.new(body['error'], env.response)
            end
          end
        end
      end
    end
  end
end
