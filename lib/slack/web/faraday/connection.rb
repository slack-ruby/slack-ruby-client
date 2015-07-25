module Slack
  module Web
    module Faraday
      module Connection
        private

        def connection
          options = {
            headers: { 'Accept' => 'application/json; charset=utf-8', 'User-Agent' => user_agent },
            url: endpoint
          }

          ::Faraday::Connection.new(options) do |connection|
            connection.use ::Faraday::Request::Multipart
            connection.use ::Faraday::Request::UrlEncoded
            connection.use ::Faraday::Response::RaiseError
            connection.use ::Slack::Web::Faraday::Response::RaiseError
            connection.use ::FaradayMiddleware::ParseJson
            connection.adapter(::Faraday.default_adapter)
          end
        end
      end
    end
  end
end
