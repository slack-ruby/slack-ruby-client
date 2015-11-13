module Slack
  module RealTime
    module Concurrency
      autoload :Eventmachine, 'slack/real_time/concurrency/eventmachine'
      autoload :Celluloid, 'slack/real_time/concurrency/celluloid'
    end
  end
end
