module Slack
  module RealTime
    module Concurrency
      module Mock
        class WebSocket
        end

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
            @driver = WebSocket.new(url, nil, options)
          end
        end
      end
    end
  end
end
