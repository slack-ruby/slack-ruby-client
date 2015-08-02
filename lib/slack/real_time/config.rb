module Slack
  module RealTime
    module Config
      extend self

      ATTRIBUTES = [
        :token,
        :websocket_ping,
        :websocket_proxy
      ]

      attr_accessor(*Config::ATTRIBUTES)

      def reset
        self.websocket_ping = 30
        self.websocket_proxy = nil
        self.token = nil
      end
    end

    class << self
      def configure
        block_given? ? yield(Config) : Config
      end

      def config
        Config
      end
    end
  end
end

Slack::RealTime::Config.reset
