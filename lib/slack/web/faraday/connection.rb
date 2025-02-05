# frozen_string_literal: true
module Slack
  module Web
    module Faraday
      module Connection
        include ConnectionOptions

        private

        def options
          @options ||= begin
            options = connection_options.dup
            options[:headers]['Accept'] = 'application/json; charset=utf-8'
            options
          end
        end

        def connection
          @connection ||=
            ::Faraday::Connection.new(endpoint, options) do |connection|
              connection.request :multipart
              connection.request :url_encoded
              connection.use ::Slack::Web::Faraday::Response::RaiseError
              connection.response :mashify, mash_class: Slack::Messages::Message
              connection.response :json, content_type: /\b*$/
              connection.use ::Slack::Web::Faraday::Response::WrapError
              connection.response :logger, logger if logger
              connection.adapter adapter
            end
        end
      end
    end
  end
end
