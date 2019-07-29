# frozen_string_literal: true
module Slack
  module RealTime
    module Concurrency
      module Mock
        class WebSocket
        end

        class Socket < ::Slack::RealTime::Socket
          def self.close; end

          def start_async(client)
            reactor = Thread.new {}
            client.run_loop
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
