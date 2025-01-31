# frozen_string_literal: true
module Slack
  module Web
    module Faraday
      module Connection
        private

        def connection
          @connection ||=
            begin
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

              ::Faraday::Connection.new(endpoint, options) do |connection|
                connection.request :multipart
                connection.request :url_encoded
                connection.use ::Slack::Web::Faraday::Response::RaiseError
                connection.response :mashify, mash_class: Slack::Messages::Message
                connection.response :json, content_type: /\b*$/
                connection.use ::Slack::Web::Faraday::Response::WrapError
                connection.response :logger, logger, bodies: true if logger
                connection.adapter adapter
              end
            end
        end
      end
    end
  end
end
