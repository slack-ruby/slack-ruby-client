module Slack
  module Web
    module Faraday
      module Response
        class RaiseError < ::Faraday::Response::Middleware
          def on_complete(env)
            body = env.body
            return if body['ok']
            fail Slack::Web::Api::Error.new(body['error'], env.response)
          end
        end
      end
    end
  end
end
