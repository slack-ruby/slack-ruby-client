require 'faye/websocket'
require 'eventmachine'

module Slack
  module RealTime
    module Concurrency
      module Eventmachine
        class Socket < Slack::RealTime::Concurrency::Faye::Socket
          def self.close
            ::EM.stop
          end

          def self.run(*args)
            ::EM.run do
              yield new(*args)
            end
          end
        end
      end
    end
  end
end
