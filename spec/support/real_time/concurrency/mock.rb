module Slack
  module RealTime
    module Concurrency
      module Mock
        class WebSocket
        end

        class Socket < ::Slack::RealTime::Socket
          def self.close
          end

          def start_async
            reactor = Thread.new {}
            yield self if block_given?
            reactor
          end

          def send_data(message)
            driver.send(message)
          end

          protected

          def connect
            @driver = WebSocket.new(url, nil, options)
          end
        end
      end
    end
  end
end
