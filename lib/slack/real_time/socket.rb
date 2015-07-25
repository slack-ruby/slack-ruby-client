module Slack
  module RealTime
    class Socket
      attr_accessor :url

      def initialize(url)
        @url = url
      end

      def connect!(&_block)
        return if connected?

        @ws = Faye::WebSocket::Client.new(url)

        @ws.on :close do |event|
          close(event)
        end

        yield @ws if block_given?
      end

      def disconnect!
        @ws.close if @ws
      end

      def connected?
        !@ws.nil?
      end

      protected

      def close(_event)
        @ws = nil
      end
    end
  end
end
