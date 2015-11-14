require 'faye/websocket'

module Slack
  module RealTime
    module Concurrency
      module Faye
        class Socket < ::Slack::RealTime::Socket
          def self.close
          end

          def self.run(*args)
            yield new(*args)
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
