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

      def send_data(message)
        case message
        when Numeric then driver.text(message.to_s)
        when String  then driver.text(message)
        when Array   then driver.binary(message)
        else false
        end
      end

      def connect!
        return if connected?

        connect

        yield driver if block_given?
      end

      def disconnect!
        driver.close
      end

      def connected?
        !driver.nil?
      end

      def start_sync(&block)
        thread = start_async(&block)
        thread.join if thread
      rescue Interrupt
        thread.exit if thread
      end

      # @return [#join]
      def start_async
        fail NotImplementedError, "Expected #{self.class} to implement #{__method__}."
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
        fail NotImplementedError, "Expected #{self.class} to implement #{__method__}."
      end

      def close(_event)
        @driver = nil
      end
    end
  end
end
