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

      def initialize(options = {})
        @callbacks = Hash.new { |h, k| h[k] = [] }
        Slack::RealTime::Config::ATTRIBUTES.each do |key|
          send("#{key}=", options[key] || Slack::RealTime.config.send(key))
        end
        @store_class = options.key?(:store_class) ? options[:store_class] : Slack::RealTime::Store
        @token ||= Slack.config.token
        @web_client = Slack::Web::Client.new(token: token)
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
      # @yieldparam [Websocket::Driver] driver
      def start!(&block)
        socket = build_socket
        socket.start_sync { run_loop(socket, &block) }
      end

      # Start RealTime client and return immediately.
      # The RealTime::Client will run in the background.
      # @yieldparam [Websocket::Driver] driver
      def start_async(&block)
        socket = build_socket
        socket.start_async { run_loop(socket, &block) }
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

      protected

      # @return [Slack::RealTime::Socket]
      def build_socket
        fail ClientAlreadyStartedError if started?
        start = web_client.rtm_start(start_options)
        data = Slack::Messages::Message.new(start)
        @url = data.url
        @store = @store_class.new(data) if @store_class
        socket_class.new(@url, socket_options)
      end

      def socket_options
        socket_options = {}
        socket_options[:ping] = websocket_ping if websocket_ping
        socket_options[:proxy] = websocket_proxy if websocket_proxy
        socket_options
      end

      def run_loop(socket)
        @socket = socket

        @socket.connect! do |driver|
          yield driver if block_given?

          driver.on :open do |event|
            open(event)
            callback(event, :open)
          end

          driver.on :message do |event|
            dispatch(event)
          end

          driver.on :close do |event|
            callback(event, :close)
            close(event)
          end
        end
      end

      attr_reader :callbacks
      def socket_class
        concurrency::Socket
      end

      def send_json(data)
        fail ClientNotStartedError unless started?
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
      end

      def dispatch(event)
        return false unless event.data
        data = Slack::Messages::Message.new(JSON.parse(event.data))
        type = data.type
        return false unless type
        type = type.to_s
        run_handlers(type, data) if @store
        run_callbacks(type, data)
      end

      def run_handlers(type, data)
        handler = Slack::RealTime::Client.events[type]
        handler.call(self, data) if handler
      end

      def run_callbacks(type, data)
        callbacks = self.callbacks[type]
        return false unless callbacks
        callbacks.each do |c|
          c.call(data)
        end
        true
      end
    end
  end
end
