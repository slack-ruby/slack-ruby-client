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
          options = options.merge(token: token)
          use_full_response = options.fetch(:full_response) { full_response }
          options.delete(:full_response)

          response = connection.send(method) do |request|
            case method
            when :get, :delete
              request.url(path, options)
            when :post, :put
              request.path = path
              request.body = options unless options.empty?
            end
            request.options.merge!(options.delete(:request)) if options.key?(:request)
          end

          if use_full_response
            response
          else
            response.body
          end
        end
      end
    end
  end
end
