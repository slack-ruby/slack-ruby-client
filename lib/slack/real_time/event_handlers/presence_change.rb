module Slack
  module RealTime
    module EventHandlers
      module PresenceChange
        # A team member's presence changed.
        # @see https://api.slack.com/events/presence_change
        # @see https://github.com/dblock/slack-api-ref/blob/master/events/presence_change.json
        def self.call(client, data)
          user = client.users[data.user]
          user.presence = data.presence if user
        end
      end
    end
  end
end

Slack::RealTime::Client.events['presence_change'] = Slack::RealTime::EventHandlers::PresenceChange
