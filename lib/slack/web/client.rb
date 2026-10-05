# frozen_string_literal: true
module Slack
  module Web
    class Client
      include Faraday::Connection
      include Faraday::Request
      include Api::Endpoints
      include Api::Helpers
      include Api::Options

      attr_accessor(*Config::ATTRIBUTES)

      def initialize(options = {})
        Slack::Web::Config::ATTRIBUTES.each do |key|
          send("#{key}=", options.fetch(key, Slack::Web.config.send(key)))
        end

        @logger ||= Slack::Config.logger || Slack::Logger.default
        @token ||= Slack.config.token
      end

      def with_response(&block)
        raise ArgumentError, 'response callback block is required' unless block

        with_callback(:@response_callbacks, block)
      end

      def with_request(&block)
        raise ArgumentError, 'request callback block is required' unless block

        with_callback(:@request_callbacks, block)
      end

      def with_error(&block)
        raise ArgumentError, 'error callback block is required' unless block

        with_callback(:@error_callbacks, block)
      end

      class << self
        def configure
          block_given? ? yield(Config) : Config
        end

        def config
          Config
        end
      end

      private

      def with_callback(variable, block)
        copy = dup
        copy.instance_variable_set(:@connection, nil)
        copy.instance_variable_set(:@options, nil)
        copy.instance_variable_set(variable, Array(instance_variable_get(variable)) + [block])
        copy
      end
    end
  end
end
