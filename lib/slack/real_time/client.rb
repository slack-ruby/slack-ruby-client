module Slack
  module RealTime
    class Client
      class ClientNotStartedError < StandardError; end
      class ClientAlreadyStartedError < StandardError; end

      attr_accessor :url

      def initialize(url)
        @url = url
        @callbacks ||= {}
      end

      def on(type, &block)
        type = type.to_s
        @callbacks[type] ||= []
        @callbacks[type] << block
      end

      def start!
        fail ClientAlreadyStartedError if started?
        EM.run do
          @ws = Faye::WebSocket::Client.new(@url)

          @ws.on :open do |event|
            open(event)
          end

          @ws.on :message do |event|
            dispatch(event)
          end

          @ws.on :close do |event|
            close(event)
          end
        end
      end

      def stop!
        fail ClientNotStartedError unless started?
        @ws.close if @ws
      end

      def started?
        !@ws.nil?
      end

      protected

      def open(_event)
      end

      def close(_event)
        @ws = nil
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
