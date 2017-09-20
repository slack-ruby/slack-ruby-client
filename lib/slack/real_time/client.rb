module Slack
  module RealTime
    class Client
      class ClientNotStartedError < StandardError; end
      class ClientAlreadyStartedError < StandardError; end

      include Api::MessageId
      include Api::Ping
      include Api::Message
      include Api::Typing

      @events = {}

      class << self
        attr_accessor :events
      end

      attr_accessor :web_client
      attr_accessor :store
      attr_accessor :url
      attr_accessor(*Config::ATTRIBUTES)

      protected :logger, :logger=
      protected :store_class, :store_class=

      def initialize(options = {})
        @callbacks = Hash.new { |h, k| h[k] = [] }
        Slack::RealTime::Config::ATTRIBUTES.each do |key|
          send("#{key}=", options.key?(key) ? options[key] : Slack::RealTime.config.send(key))
        end
        @token ||= Slack.config.token
        @logger ||= (Slack::Config.logger || Slack::Logger.default)
        @web_client = Slack::Web::Client.new(token: token, logger: logger)
      end

      [:users, :self, :channels, :team, :teams, :groups, :ims, :bots].each do |store_method|
        define_method store_method do
          store.send(store_method) if store
        end
      end

      def on(type, &block)
        type = type.to_s
        callbacks[type] << block
      end

      # Start RealTime client and block until it disconnects.
      def start!(&block)
        @callback = block if block_given?
        @socket = build_socket
        @socket.start_sync(self)
      end

      # Start RealTime client and return immediately.
      # The RealTime::Client will run in the background.
      def start_async(&block)
        @callback = block if block_given?
        @socket = build_socket
        @socket.start_async(self)
      end

      def stop!
        fail ClientNotStartedError unless started?
        @socket.disconnect! if @socket
      end

      def started?
        @socket && @socket.connected?
      end

      class << self
        def configure
          block_given? ? yield(config) : config
        end

        def config
          Config
        end
      end

      def run_loop
        @socket.connect! do |driver|
          @callback.call(driver) if @callback

          driver.on :open do |event|
            logger.debug("#{self.class}##{__method__}") { event.class.name }
            open(event)
            callback(event, :open)
          end

          driver.on :message do |event|
            logger.debug("#{self.class}##{__method__}") { "#{event.class}, #{event.data}" }
            dispatch(event)
          end

          driver.on :close do |event|
            logger.debug("#{self.class}##{__method__}") { event.class.name }
            callback(event, :close)
            close(event)
            callback(event, :closed)
          end
        end
      end

      protected

      # @return [Slack::RealTime::Socket]
      def build_socket
        fail ClientAlreadyStartedError if started?
        start = web_client.send(rtm_start_method, start_options)
        data = Slack::Messages::Message.new(start)
        @url = data.url
        @store = @store_class.new(data) if @store_class
        socket_class.new(@url, socket_options)
      end

      def rtm_start_method
        if start_method
          start_method
        elsif @store_class && @store_class <= Slack::RealTime::Stores::Store
          :rtm_start
        else
          :rtm_connect
        end
      end

      def socket_options
        socket_options = {}
        socket_options[:ping] = websocket_ping if websocket_ping
        socket_options[:proxy] = websocket_proxy if websocket_proxy
        socket_options[:logger] = logger
        socket_options
      end

      attr_reader :callbacks
      def socket_class
        concurrency::Socket
      end

      def send_json(data)
        fail ClientNotStartedError unless started?
        logger.debug("#{self.class}##{__method__}") { data }
        @socket.send_data(data.to_json)
      end

      def open(_event)
      end

      def close(_event)
        socket = @socket
        @socket = nil

        [socket, socket_class].each do |s|
          s.close if s.respond_to?(:close)
        end
      end

      def callback(event, type)
        callbacks = self.callbacks[type.to_s]
        return false unless callbacks
        callbacks.each do |c|
          c.call(event)
        end
        true
      rescue StandardError => e
        logger.error e
        false
      end

      def dispatch(event)
        return false unless event.data
        data = Slack::Messages::Message.new(JSON.parse(event.data))
        type = data.type
        return false unless type
        type = type.to_s
        logger.debug("#{self.class}##{__method__}") { data.to_s }
        run_handlers(type, data) if @store
        run_callbacks(type, data)
      rescue StandardError => e
        logger.error e
        false
      end

      def run_handlers(type, data)
        handlers = store.class.events[type.to_s]
        handlers.each do |handler|
          store.instance_exec(data, &handler)
        end if handlers
      rescue StandardError => e
        logger.error e
        false
      end

      def run_callbacks(type, data)
        callbacks = self.callbacks[type]
        return false unless callbacks
        callbacks.each do |c|
          c.call(data)
        end
        true
      rescue StandardError => e
        logger.error e
        false
      end
    end
  end
end
