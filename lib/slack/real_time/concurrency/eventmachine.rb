require 'faye/websocket'
require 'eventmachine'

module Slack
  module RealTime
    module Concurrency
      module Eventmachine
        class Client < Faye::WebSocket::Client
          attr_reader :logger
          protected :logger

          def initialize(url, protocols = nil, options = {})
            @logger = options.delete(:logger) || Slack::RealTime::Config.logger || Slack::Config.logger
            super
          end

          def parse(data)
            logger.debug("#{self.class}##{__method__}") { data }
            super data
          end

          def write(data)
            logger.debug("#{self.class}##{__method__}") { data }
            super data
          end
        end

        class Socket < Slack::RealTime::Socket
          def start_async(client)
            thread = ensure_reactor_running

            client.run_loop

            thread
          end

          def send_data(message)
            logger.debug("#{self.class}##{__method__}") { message }
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
            @driver = Client.new(url, nil, options.merge(logger: logger))
          end
        end
      end
    end
  end
end
