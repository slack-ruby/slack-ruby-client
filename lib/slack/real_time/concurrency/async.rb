require 'async/websocket'

module Slack
  module RealTime
    module Concurrency
      module Async
        class Client < ::Async::WebSocket::Client
          extend ::Forwardable
          def_delegators :driver, :on

          def text(message)
            driver.text(message)
          end

          def binary(data)
            socket.write(data)
          end
        end

        class Socket < Slack::RealTime::Socket
          attr_reader :client

          def start_async(client)
            @client = client
            client.run_loop
          end

          def connect!
            super
            run_loop
          end

          def close
            driver.close
            super
          end

          def run_loop
            @socket = build_socket
            @connected = @socket.connect
            while event = driver.next_event

            end
          end

          protected

          def build_ssl_context
            # TODO: context.set_params verify_mode: OpenSSL::SSL::VERIFY_PEER
            { ssl_context: OpenSSL::SSL::SSLContext.new(:TLSv1_2_client) }
          end

          def build_tcp_options
            {
              reuse_port: false
            }
          end

          def build_socket
            socket = ::Async::IO::Endpoint.tcp(addr, port, build_tcp_options)
            socket = ::Async::IO::SSLEndpoint.new(socket, build_ssl_context) if secure?
            socket
          end

          def build_driver
            Client.new(build_socket.connect, url)
          end

          def connect
            @driver = build_driver
          end
        end
      end
    end
  end
end
