# frozen_string_literal: true

module Slack
  module RealTime
    module Stores
      # Doesn't store anything.
      class Base
        @events = Hash.new { |h, k| h[k] = [] }

        class << self
          attr_reader :events

          def inherited(subclass)
            super
            subclass.instance_variable_set :@events, events.dup
          end

          def on(event, &handler)
            events[event.to_s] << handler
          end
        end

        attr_accessor :users, :bots, :channels, :groups, :teams, :ims

        def self
          nil
        end

        def team
          nil
        end

        def initialize(_attrs); end
      end
    end
  end
end
