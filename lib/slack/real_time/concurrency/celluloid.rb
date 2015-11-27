require 'websocket/driver'
require 'socket'
require 'forwardable'
require 'celluloid/io'

module Slack
  module RealTime
    module Concurrency
      module Celluloid
        class Socket < Slack::RealTime::Socket
          include ::Celluloid::IO
          include ::Celluloid::Logger

          BLOCK_SIZE = 4096

          extend ::Forwardable
          def_delegator :socket, :write
          def_delegators :driver, :text, :binary, :close

          attr_reader :socket

          def initialize(*args)
            super
            @driver = build_driver
          end

          # @yieldparam [WebSocket::Driver] driver
          def connect!
            super

            driver.start
            future.run_loop
          end

          def run_loop
            loop { read } if socket
          rescue EOFError
            # connection closed
          end

          def read
            buffer = socket.readpartial(BLOCK_SIZE)
            driver.parse buffer
          end

          def start_async
            future = yield self if block_given?

            Actor.new(future)
          end

          protected

          class Actor
            attr_reader :future

            def initialize(future)
              @future = future
            end

            def join
              @future.value
            end
          end

          def connected?
            !@connected.nil?
          end

          def build_socket
            socket = TCPSocket.new(addr, port)
            socket = SSLSocket.new(socket, build_ssl_context) if secure?
            socket
          end

          def build_ssl_context
            OpenSSL::SSL::SSLContext.new(:TLSv1_2_client)
          end

          def build_driver
            ::WebSocket::Driver.client(self)
          end

          def connect
            @socket = build_socket
            @connected = @socket.connect
          end
        end
      end
    end
  end
end
