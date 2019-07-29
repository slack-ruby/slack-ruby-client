# frozen_string_literal: true
module Slack
  module RealTime
    class Event
      attr_accessor :data

      def initialize(data)
        @data = data.to_json
      end
    end
  end
end
