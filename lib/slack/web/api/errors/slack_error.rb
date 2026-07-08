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

          def error
            response.body.error
          end

          def errors
            response.body.errors
          end

          def response_metadata
            response.body.response_metadata
          end

          def to_s
            errors_message = ", errors=#{errors}" unless errors.nil?
            response_metadata_message = ", response_metadata=#{response_metadata}" unless response_metadata.nil?
            "#{error}#{errors_message || ''}#{response_metadata_message || ''}"
          end
        end
      end
    end
  end
end
