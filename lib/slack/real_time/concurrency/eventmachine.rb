require 'faye/websocket'
require 'eventmachine'

module Slack
  module RealTime
    module Concurrency
      module Eventmachine
        class Socket < Slack::RealTime::Socket
          def self.close
          end

          def self.run(*args)
            ::EM.run do
              yield new(*args)
            end
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
