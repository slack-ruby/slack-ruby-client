require 'async/websocket'
require 'async/clock'

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

          def start_sync(client)
            start_reactor(client).wait
          end

          def start_async(client)
            Thread.new do
              start_reactor(client)
            end
          end

          def start_reactor(client)
            Async do |task|
              self.restart_async(client, @url)

              if client.run_ping?
                task.async do |subtask|
                  subtask.annotate 'client keep-alive'

                  while true
                    subtask.sleep client.websocket_ping
                    run_ping!
                  end
                end
              end
            end
          end

          def restart_async(client, new_url)
            @url = new_url
            @last_message_at = current_time

            if @client_task
              @client_task.stop
            end

            @client_task = task.async do |subtask|
              subtask.annotate 'client run-loop'
              client.run_loop
            end
          end

          def current_time
            ::Async::Clock.now
          end

          def connect!
            super
            run_loop
          end

          # Close the socket.
          def close
            @socket.close if @socket
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
