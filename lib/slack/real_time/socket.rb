module Slack
  module RealTime
    class Socket
      attr_accessor :url
      attr_accessor :options

      attr_reader :driver

      def initialize(url, options = {})
        @url = url
        @options = options
        @driver = nil
      end

      def send_data(data)
        driver.text(data) if driver
      end

      def connect!(&_block)
        return if connected?

        connect

        yield driver if block_given?
      end

      def disconnect!
        driver.close if driver
      end

      def connected?
        !driver.nil?
      end

      def self.run(&block)
        yield
      end

      protected

      def addr
        URI(url).host
      end

      def secure?
        port == URI::HTTPS::DEFAULT_PORT
      end

      def port
        case (uri = URI(url)).scheme
          when 'wss'.freeze, 'https'.freeze
            URI::HTTPS::DEFAULT_PORT
          when 'ws', 'http'.freeze
            URI::HTTP::DEFAULT_PORT
          else
            uri.port
        end
      end

      def connect
        raise "Expected #{self.class} to implement #{__method__}"
      end

      def close(_event)
        @driver = nil
      end
    end
  end
end
