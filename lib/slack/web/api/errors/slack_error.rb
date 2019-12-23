# frozen_string_literal: true
module Slack
  module Web
    module Api
      module Errors
        class SlackError < ::Faraday::Error
          attr_reader :response

          def initialize(message, response = nil)
            super message
            @response = response
          end
        end
      end
    end
  end
end
