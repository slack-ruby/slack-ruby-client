# frozen_string_literal: true
module Slack
  module Web
    module Faraday
      module Request
        def get(path, options = {})
          request(:get, path, options)
        end

        def post(path, options = {})
          request(:post, path, options)
        end

        def put(path, options = {})
          request(:put, path, options)
        end

        def delete(path, options = {})
          request(:delete, path, options)
        end

        private

        def request(method, path, options)
          response = perform_request(method, path, options)
          Array(@response_callbacks).each { |callback| callback.call(response) }
          response.body
        end

        def perform_request(method, path, options)
          configuring_request = false
          perform_http_request(method, -> { configuring_request }) do |request|
            case method
            when :get, :delete
              request.url(path, options)
            when :post, :put
              request.path = path
              options.compact! if options.respond_to? :compact
              request.body = options unless options.empty?
            end
            request.headers['Authorization'] = "Bearer #{token}" if token

            request.options.merge!(options.delete(:request)) if options.key?(:request)
            configuring_request = true
            Array(@request_callbacks).each { |callback| callback.call(request) }
            configuring_request = false
          end
        rescue ::Faraday::Error => e
          raise if configuring_request

          Array(@error_callbacks).each { |callback| callback.call(e) }
          raise
        end

        def perform_http_request(method, configuring_request, &block)
          connection.send(method, &block)
        rescue ::Faraday::ParsingError => e
          raise if configuring_request.call

          raise Slack::Web::Api::Errors::ParsingError, e.response
        end
      end
    end
  end
end
