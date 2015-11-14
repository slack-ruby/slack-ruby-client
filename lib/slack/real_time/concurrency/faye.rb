require 'faye/websocket'

module Slack
  module RealTime
    module Concurrency
      module Faye
        class Socket < ::Slack::RealTime::Socket
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
