require 'faye/websocket'
require 'eventmachine'

module Slack
  module RealTime
    module Concurrency
      module Eventmachine
        class Socket < Slack::RealTime::Socket
          def self.close
          end

          def self.run(*args, &block)
            ::EM.run do
              run_async(*args, &block)
            end
          end

          def self.run_async(*args)
            ::Faye::WebSocket.ensure_reactor_running

            socket = new(*args)
            yield socket if block_given?
            socket
          end

          def send_data(message)
            driver.send(message)
          end

          protected

          def connect
            @driver = ::Faye::WebSocket::Client.new(url, nil, options)
          end
        end
      end
    end
  end
end
