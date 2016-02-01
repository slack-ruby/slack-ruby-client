module Slack
  module RealTime
    module EventHandlers
      module ManualPresenceChange
        # You manually updated your presence.
        # @see https://api.slack.com/events/manual_presence_change
        # @see https://github.com/dblock/slack-api-ref/blob/master/events/manual_presence_change.json
        def self.call(client, data)
          client.self['presence'] = data['presence']
        end
      end
    end
  end
end

Slack::RealTime::Client.events['manual_presence_change'] = Slack::RealTime::EventHandlers::ManualPresenceChange
