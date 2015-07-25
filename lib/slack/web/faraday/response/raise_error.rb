module Slack
  module Web
    module Faraday
      module Response
        class RaiseError < ::Faraday::Response::Middleware
          def on_complete(env)
            body = env.body
            fail Slack::Web::Api::Error, body['error'] unless body['ok']
          end
        end
      end
    end
  end
end
