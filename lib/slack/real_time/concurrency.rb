# frozen_string_literal: true
module Slack
  module RealTime
    module Concurrency
      autoload :Async, 'slack/real_time/concurrency/async'
      autoload :Eventmachine, 'slack/real_time/concurrency/eventmachine'
      autoload :Celluloid, 'slack/real_time/concurrency/celluloid'
    end
  end
end
