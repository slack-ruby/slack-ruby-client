require 'faye/websocket'
require 'eventmachine'

module Slack
  module RealTime
    module Concurrency
      module Eventmachine
        class Socket < Slack::RealTime::Socket
          def start_async
            thread = ensure_reactor_running

            yield self if block_given?

            thread
          end

          def send_data(message)
            logger.debug('#send_data') { message }
            driver.send(message)
          end

          protected
          # @return [Thread]
          def ensure_reactor_running
            return if EventMachine.reactor_running?

            reactor = Thread.new { EventMachine.run }
            Thread.pass until EventMachine.reactor_running?
            reactor
          end

          def connect
            logger = self.logger

            socket_logging = Module.new do
              define_method(:parse) do |data|
                logger.debug('#read') { data }
                super(data)
              end

              define_method(:write) do |data|
                logger.debug('#write') { data }
                super(data)
              end
            end

            @driver = ::Faye::WebSocket::Client.allocate
            @driver.extend(socket_logging)
            @driver.__send__(:initialize, url, nil, options)
          end
        end
      end
    end
  end
end
