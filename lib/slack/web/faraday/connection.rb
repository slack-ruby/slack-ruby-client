# frozen_string_literal: true
module Slack
  module Web
    module Faraday
      module Connection
        def default_options
          options = {
            headers: { 'Accept' => 'application/json; charset=utf-8' }
          }
          options[:headers]['User-Agent'] = user_agent if user_agent
          options[:proxy] = proxy if proxy
          options[:ssl] = { ca_path: ca_path, ca_file: ca_file } if ca_path || ca_file

          request_options = {}
          request_options[:timeout] = timeout if timeout
          request_options[:open_timeout] = open_timeout if open_timeout
          options[:request] = request_options if request_options.any?
          options
        end

        def create_connection(expect_json_response: true)
          options = default_options
          ::Faraday::Connection.new(endpoint, options) do |connection|
            connection.request :multipart
            connection.request :url_encoded
            connection.use ::Slack::Web::Faraday::Response::RaiseError if expect_json_response
            connection.response :mashify, mash_class: Slack::Messages::Message
            connection.response :json, content_type: /\b*$/ if expect_json_response
            connection.use ::Slack::Web::Faraday::Response::WrapError
            connection.response :logger, logger if logger
            connection.adapter adapter
          end
        end

        def connection
          @connection ||= create_connection
        end

        def connection_without_response_parsing
          @connection_without_response_parsing ||= create_connection(false)
        end

        private :create_connection
      end
    end
  end
end
