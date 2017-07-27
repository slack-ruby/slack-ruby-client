module Slack
  module Web
    module Api
      module Errors
        class SlackError < ::Faraday::Error
          attr_reader :response

          def initialize(message, response = nil)
            @response = response
            super message
          end
        end
      end
    end
  end
end
