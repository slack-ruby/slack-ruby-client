# frozen_string_literal: true
module Slack
  module Web
    module Faraday
      module Response
        class StoreScopes < ::Faraday::Response::Middleware
          attr_accessor :client

          def initialize(app = nil, options = {})
            super(app)
            self.client = options[:client]
          end

          def on_complete(env)
            raw_scopes = env.response_headers[:'x-oauth-scopes']
            client.oauth_scopes = raw_scopes&.split(',')
          end
        end
      end
    end
  end
end
