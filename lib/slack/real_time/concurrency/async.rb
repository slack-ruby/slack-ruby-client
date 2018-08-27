require 'async/websocket'

module Slack
  module RealTime
    module Concurrency
      module Async
        class Client < ::Async::WebSocket::Client
          extend ::Forwardable
          def_delegators :@driver, :on

          def text(message)
            @driver.text(message)
          end

          def binary(data)
            @driver.binary(data)
          end
        end

        class Socket < Slack::RealTime::Socket
          attr_reader :client

          def start_async(client)
            Thread.new do
              ::Async::Reactor.run do
                client.run_loop
              end
            end
          end

          def connect!
            super
            run_loop
          end

          def close
            @driver.close
            super
          end

          def run_loop
            while @driver && @driver.next_event
              # $stderr.puts event.inspect
            end
          end

          protected

          def build_ssl_context
            OpenSSL::SSL::SSLContext.new(:TLSv1_2_client).tap do |ctx|
              ctx.set_params(verify_mode: OpenSSL::SSL::VERIFY_PEER)
            end
          end

          def build_endpoint
            endpoint = ::Async::IO::Endpoint.tcp(addr, port)
            endpoint = ::Async::IO::SSLEndpoint.new(endpoint, ssl_context: build_ssl_context) if secure?
            endpoint
          end

          def connect
            @driver = Client.new(build_endpoint.connect, url)
          end
        end
      end
    end
  end
end
