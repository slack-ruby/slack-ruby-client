require 'async/websocket'
require 'async/clock'

module Slack
  module RealTime
    module Concurrency
      module Async
        class Reactor < ::Async::Reactor
          def_delegators :@timers, :cancel
        end

        class Client < ::Async::WebSocket::Client
          extend ::Forwardable
          def_delegators :@driver, :on, :text, :binary, :emit
        end

        class Socket < Slack::RealTime::Socket
          attr_reader :client

          def start_async(client)
            @reactor = Reactor.new
            Thread.new do
              @reactor.every(client.websocket_ping) { client.run_ping! } if client.run_ping?
              @reactor.run do |task|
                task.async do
                  client.run_loop
                end
              end
            end
          end

          def restart_async(client, new_url)
            @url = new_url
            @last_message_at = current_time
            return unless @reactor
            @reactor.async do
              client.run_loop
            end
          end

          def disconnect!
            super
            @reactor.cancel
          end

          def current_time
            ::Async::Clock.now
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
