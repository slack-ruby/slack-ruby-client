module Slack
  module RealTime
    autoload :Socket, 'slack/real_time/socket'
    autoload :Eventmachine, 'slack/real_time/eventmachine'
    autoload :Celluloid, 'slack/real_time/celluloid'
  end
end
