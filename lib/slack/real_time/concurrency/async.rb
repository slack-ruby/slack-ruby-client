require 'async/websocket'

module Slack
  module RealTime
    module Concurrency
      module Async
        class Client < ::Async::WebSocket::Client
          extend ::Forwardable
          def_delegators :@driver, :on, :text, :binary, :emit
        end

        class Socket < Slack::RealTime::Socket
          attr_reader :client

          def start_async(client)
            Thread.new do
              ::Async::Reactor.run do |task|
                task.async do
                  client.run_loop
                end
                task.async do |subtask|
                  client.run_ping! do |delay|
                    subtask.sleep delay
                  end
                end
              end
            end
          end

          def restart_async(client)
            ::Async::Reactor.run do
              client.build_socket
              client.run_loop
            end
          end

          def current_time
            Async::Clock.now
          end

          def connect!
            super
            run_loop
          end

          def close
            @closing = true
            @driver.close if @driver
            super
          end

          def run_loop
            @closing = false
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

          def connect_socket
            build_endpoint.connect
          end

          def connect
            @socket = connect_socket
            @driver = Client.new(@socket, url)
          end
        end
      end
    end
  end
end
