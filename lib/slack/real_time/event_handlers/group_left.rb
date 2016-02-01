module Slack
  module RealTime
    module EventHandlers
      module GroupLeft
        # You left a private group.
        # @see https://api.slack.com/events/group_left
        # @see https://github.com/dblock/slack-api-ref/blob/master/events/group_left.json
        def self.call(client, data)
          channel = client.groups[data.channel]
          channel.members.delete(client.self.id) if channel && channel.key?('members')
        end
      end
    end
  end
end

Slack::RealTime::Client.events['group_left'] = Slack::RealTime::EventHandlers::GroupLeft
