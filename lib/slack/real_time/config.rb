# frozen_string_literal: true
module Slack
  module RealTime
    module Config
      class NoConcurrencyError < StandardError; end

      extend self

      ATTRIBUTES = %i[
        token
        websocket_ping
        websocket_proxy
        concurrency
        start_method
        start_options
        store_class
        logger
      ].freeze

      attr_accessor(*Config::ATTRIBUTES)

      def reset
        self.websocket_ping = 30
        self.websocket_proxy = nil
        self.token = nil
        self.concurrency = method(:detect_concurrency)
        self.start_method = nil
        self.start_options = { request: { timeout: 180 } }
        self.store_class = Slack::RealTime::Store
        self.logger = nil
      end

      def concurrency
        (val = @concurrency).respond_to?(:call) ? val.call : val
      end

      private

      def detect_concurrency
        %i[Async Eventmachine Celluloid].each do |concurrency|
          begin
            return Slack::RealTime::Concurrency.const_get(concurrency)
          rescue LoadError, NameError
            false # could not be loaded, missing dependencies
          end
        end

        raise(
          NoConcurrencyError,
          'Missing concurrency. Add async-websocket, faye-websocket ' \
          'or celluloid-io to your Gemfile.'
        )
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
