module Slack
  module RealTime
    module EventHandlers
      module GroupUnarchive
        # A private group was unarchived.
        # @see https://api.slack.com/events/group_unarchive
        # @see https://github.com/dblock/slack-api-ref/blob/master/events/group_unarchive.json
        def self.call(client, data)
          channel = client.groups[data.channel]
          channel.is_archived = false if channel
        end
      end
    end
  end
end

Slack::RealTime::Client.events['group_unarchive'] = Slack::RealTime::EventHandlers::GroupUnarchive
