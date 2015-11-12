module Slack
  module RealTime
    class Client
      class ClientNotStartedError < StandardError; end
      class ClientAlreadyStartedError < StandardError; end

      include Api::MessageId
      include Api::Ping
      include Api::Message
      include Api::Typing

      attr_accessor :web_client
      attr_accessor(*Config::ATTRIBUTES)

      def initialize(options = {})
        @callbacks = {}
        Slack::RealTime::Config::ATTRIBUTES.each do |key|
          send("#{key}=", options[key] || Slack::RealTime.config.send(key))
        end
        @token ||= Slack.config.token
        @web_client = Slack::Web::Client.new(token: token)
      end

      [:url, :team, :self, :users, :channels, :groups, :ims, :bots].each do |attr|
        define_method attr do
          @options[attr.to_s] if @options
        end
      end

      def on(type, &block)
        type = type.to_s
        @callbacks[type] ||= []
        @callbacks[type] << block
      end

      def start!
        EM.run do
          rtm_start!
        end
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
          block_given? ? yield(Config) : Config
        end

        def config
          Config
        end
      end

      protected

      def send_json(data)
        fail ClientNotStartedError unless started?
        @socket.send_data(data.to_json)
      end

      def open(_event)
      end

      def close(_event)
        @socket = nil
        EM.stop
      end

      def dispatch(event)
        return false unless event.data
        data = JSON.parse(event.data)
        type = data['type']
        return false unless type
        callbacks = @callbacks[type.to_s]
        return false unless callbacks
        callbacks.each do |c|
          c.call(data)
        end
        true
      end

      private

      def rtm_start!
        fail ClientAlreadyStartedError if started?
        @options = web_client.rtm_start

        socket_options = {}
        socket_options[:ping] = websocket_ping if websocket_ping
        socket_options[:proxy] = websocket_proxy if websocket_proxy

        @socket = Slack::RealTime::Socket.new(@options['url'], socket_options)

        @socket.connect! do |ws|
          ws.on :open do |event|
            open(event)
          end

          ws.on :message do |event|
            dispatch(event)
          end

          ws.on :close do |event|
            close(event)
          end
        end
      end
    end
  end
end
