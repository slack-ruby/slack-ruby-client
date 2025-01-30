# frozen_string_literal: true
module Slack
  module Web
    module Faraday
      module Response
        class RaiseError < ::Faraday::Middleware
          def on_complete(env)
            raise Slack::Web::Api::Errors::TooManyRequestsError, env.response if env.status == 429

            response_content_type_is_string = env.response&.headers&.[]('content-type')&.include?('text/plain') || false

            raise ::Faraday::ParsingError.new(nil, env.response) if !response_content_type_is_string && !env.body.is_a?(Hash)

            return unless env.success?

            body = env.body
            return if env.success? && body.is_a?(String) && response_content_type_is_string
            return unless body
            return if body['ok']

            error_message = body['error'] || body['errors'].map { |message| message['error'] }.join(',')
            error_class = Slack::Web::Api::Errors::ERROR_CLASSES[error_message]
            error_class ||= Slack::Web::Api::Errors::SlackError
            raise error_class.new(error_message, env.response)
          end
        end
      end
    end
  end
end
