# frozen_string_literal: true
module Slack
  module Web
    module Faraday
      module Response
        class WrapError < ::Faraday::Response::RaiseError
          def on_complete(env)
            super
          rescue Slack::Web::Api::Errors::SlackError
            raise
          rescue ::Faraday::ServerError
            raise Slack::Web::Api::Errors::UnavailableError.new('unavailable_error', env.response)
          end
        end
      end
    end
  end
end
