module Slack
  module RealTime
    module Concurrency
      autoload :Faye, 'slack/real_time/concurrency/faye'
      autoload :Eventmachine, 'slack/real_time/concurrency/eventmachine'
      autoload :Celluloid, 'slack/real_time/concurrency/celluloid'
    end
  end
end
