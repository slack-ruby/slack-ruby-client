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
              $stderr.puts "start_async: @driver = #{@driver}"
              ::Async::Reactor.run do
                client.run_loop
              end
            end
          end

          def connect!
            ::Async::Reactor.run do
              super
              
              run_loop
            end
          end

          def close
            @driver.close
            super
          end

          def run_loop
            while @driver and event = @driver.next_event
              # $stderr.puts event.inspect
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

          def build_endpoint
            endpoint = ::Async::IO::Endpoint.tcp(addr, port, build_tcp_options)
            endpoint = ::Async::IO::SSLEndpoint.new(endpoint, build_ssl_context) if secure?
            
            return endpoint
          end
          
          def connect
            @driver = Client.new(build_endpoint.connect, url)
          end
        end
      end
    end
  end
end
