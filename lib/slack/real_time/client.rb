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

      def initialize
        @callbacks = {}
        @web_client = Slack::Web::Client.new
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
        fail ClientAlreadyStartedError if started?
        EM.run do
          @options = web_client.rtm_start
          @socket = Slack::RealTime::Socket.new(@options['url'])

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

      def stop!
        fail ClientNotStartedError unless started?
        @socket.disconnect! if @socket
      end

      def started?
        @socket && @socket.connected?
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
    end
  end
end
