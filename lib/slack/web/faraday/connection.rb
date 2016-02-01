module Slack
  module Web
    module Faraday
      module Connection
        private

        def connection
          options = {
            headers: { 'Accept' => 'application/json; charset=utf-8' }
          }

          options[:headers]['User-Agent'] = user_agent if user_agent
          options[:proxy] = proxy if proxy
          options[:ssl] = { ca_path: ca_path, ca_file: ca_file }

          ::Faraday::Connection.new(endpoint, options) do |connection|
            connection.use ::Faraday::Request::Multipart
            connection.use ::Faraday::Request::UrlEncoded
            connection.use ::Slack::Web::Faraday::Response::RaiseError
            connection.use ::FaradayMiddleware::Mashify, mash_class: Slack::Messages::Message
            connection.use ::FaradayMiddleware::ParseJson
            connection.use ::Faraday::Response::RaiseError
            connection.response :logger, logger if logger
            connection.adapter ::Faraday.default_adapter
          end
        end
      end
    end
  end
end
