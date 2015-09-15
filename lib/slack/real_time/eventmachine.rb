require 'faye/websocket'
require 'eventmachine'

module Slack
  module RealTime
    module Eventmachine
      class Socket  < Slack::RealTime::Socket

        def self.close
          ::EM.stop
        end

        def self.run(*args)
          EM.run {
            yield new(*args)
          }
        end

        protected

        def connect
          @driver = Faye::WebSocket::Client.new(url, nil, options)
        end
      end
    end
  end
end
