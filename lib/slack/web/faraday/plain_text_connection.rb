# frozen_string_literal: true
module Slack
  module Web
    module Faraday
      module PlainTextConnection
        include ConnectionOptions

        private

        def plain_text_connection
          @plain_text_connection ||=
            ::Faraday::Connection.new(endpoint, connection_options) do |connection|
              connection.request :multipart
              connection.request :url_encoded
              connection.use ::Slack::Web::Faraday::Response::WrapError
              connection.response :logger, logger if logger
              connection.adapter adapter
            end
        end
      end
    end
  end
end
