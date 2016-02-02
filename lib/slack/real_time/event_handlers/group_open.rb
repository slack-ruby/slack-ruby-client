module Slack
  module RealTime
    module EventHandlers
      module GroupOpen
        # You opened a group channel.
        # @see https://api.slack.com/events/group_open
        # @see https://github.com/dblock/slack-api-ref/blob/master/events/group_open.json
        def self.call(client, data)
          client.groups[data.channel].is_open = true
        end
      end
    end
  end
end

Slack::RealTime::Client.events['group_open'] = Slack::RealTime::EventHandlers::GroupOpen
