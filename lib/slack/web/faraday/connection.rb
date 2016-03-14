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
          request_options = {}
          request_options[:timeout] = Slack::Config.timeout if Slack::Config.timeout
          request_options[:open_timeout] = Slack::Config.open_timeout if Slack::Config.open_timeout
          options[:request] = request_options

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
