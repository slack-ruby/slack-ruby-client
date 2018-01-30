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
              if body.has_key?('response_metadata') && body['response_metadata'].has_key?('messages')
                error_message << " Response Metadata: #{body['response_metadata']['messages'].join(',')}"
              end
              raise Slack::Web::Api::Errors::SlackError.new(error_message, env.response)
            end
          end
        end
      end
    end
  end
end
