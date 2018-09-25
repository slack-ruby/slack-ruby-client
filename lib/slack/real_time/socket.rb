module Slack
  module RealTime
    class Socket
      class SocketNotConnectedError < StandardError; end

      attr_accessor :url
      attr_accessor :options
      attr_reader :driver
      attr_reader :logger
      protected :logger

      def initialize(url, options = {})
        @url = url
        @options = options
        @driver = nil
        @logger = options.delete(:logger) || Slack::RealTime::Config.logger || Slack::Config.logger
        @alive = false
        @pending_pings = Hash.new { |_hash, ping_id| raise(KeyError, "Ping id: #{ping_id} is not valid") }
      end

      def send_data(message)
        raise SocketNotConnectedError unless connected?
        logger.debug("#{self.class}##{__method__}") { message }
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
        logger.debug("#{self.class}##{__method__}") { driver.class }

        heartbeat 30
        yield driver if block_given?
      end

      def heartbeat(delay)
        @alive = true

        driver.on :message do |event|
          event_data = JSON.parse(event.data)
          pong(event_data['reply_to']) if event_data['type'] == 'pong'
        end

        Thread.new do
          ping_int = 0
          loop do
            sleep delay
            ping_data = { type: 'ping', time: Time.now, id: "p#{ping_int += 1}" }
            ping(ping_data)
          end
        end
      end

      def ping(data)
        unless @alive
          disconnect! if connected?
          close
        end
        send_data(data.to_json)
        @pending_pings[data[:id]] = data
        @alive = false
      end

      def pong(ping_id)
        ping_data = @pending_pings[ping_id]
        diff = Time.now - ping_data[:time]
        logger.debug("Ping #{ping_id} returned a response in #{diff} seconds.")
        @pending_pings.delete(ping_id)
        @alive = true
      end

      def disconnect!
        driver.close
      end

      def connected?
        !driver.nil?
      end

      def start_sync(client)
        thread = start_async(client)
        thread.join if thread
      rescue Interrupt
        thread.exit if thread
      end

      # @return [#join]
      def start_async(_client)
        raise NotImplementedError, "Expected #{self.class} to implement #{__method__}."
      end

      def close
        @driver = nil
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
        raise NotImplementedError, "Expected #{self.class} to implement #{__method__}."
      end
    end
  end
end
