# frozen_string_literal: true
module Slack
  module Web
    module Faraday
      module Request
        def get(path, options = {}, expect_json_response: true)
          request(:get, path, options, expect_json_response)
        end

        def post(path, options = {}, expect_json_response: true)
          request(:post, path, options, expect_json_response)
        end

        def put(path, options = {}, expect_json_response: true)
          request(:put, path, options, expect_json_response)
        end

        def delete(path, options = {}, expect_json_response: true)
          request(:delete, path, options, expect_json_response)
        end

        private

        def request(method, path, options, expect_json_response)
          connection_to_use = expect_json_response ? connection : connection_without_response_parsing
          response = connection_to_use.send(method) do |request|
            case method
            when :get, :delete
              request.url(path, options)
            when :post, :put
              request.path = path
              options.compact! if options.respond_to? :compact
              request.body = options unless options.empty?
            end
            request.headers['Authorization'] = "Bearer #{token}" if token

            request.options.merge!(options.delete(:request)) if options.respond_to?(:key) && options.key?(:request)
          end
          response.body
        rescue ::Faraday::ParsingError => e
          raise Slack::Web::Api::Errors::ParsingError, e.response
        end
      end
    end
  end
end
