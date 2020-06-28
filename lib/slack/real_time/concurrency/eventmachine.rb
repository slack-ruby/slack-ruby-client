# frozen_string_literal: true
require 'faye/websocket'
require 'eventmachine'

module Slack
  module RealTime
    module Concurrency
      module Eventmachine
        class Client < Faye::WebSocket::Client
          def initialize(url, protocols = nil, options = {})
            options = options.dup
            @logger = options.delete(:logger) || Slack::RealTime::Config.logger || Slack::Config.logger
            super url, protocols, options
          end

          def parse(data)
            logger.debug("#{self.class}##{__method__}") { data }
            super data
          end

          def write(data)
            logger.debug("#{self.class}##{__method__}") { data }
            super data
          end

          protected

          attr_reader :logger
        end

        class Socket < Slack::RealTime::Socket
          def start_async(client)
            @thread = ensure_reactor_running

            if client.run_ping?
              EventMachine.add_periodic_timer client.websocket_ping_timer do
                client.run_ping!
              end
            end

            client.run_loop

            @thread
          end

          def restart_async(client, new_url)
            @url = new_url
            @last_message_at = current_time
            @thread = ensure_reactor_running

            client.run_loop

            @thread
          end

          def disconnect!
            super
            EventMachine.stop_event_loop if EventMachine.reactor_running?
            @thread = nil
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
