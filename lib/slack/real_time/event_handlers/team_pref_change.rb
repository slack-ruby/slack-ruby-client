module Slack
  module RealTime
    module EventHandlers
      module TeamPrefChange
        # A team preference has been updated.
        # @see https://api.slack.com/events/team_pref_change
        # @see https://github.com/dblock/slack-api-ref/blob/master/events/team_pref_change.json
        def self.call(client, data)
          client.team['prefs'][data['name']] = data['value']
        end
      end
    end
  end
end

Slack::RealTime::Client.events['team_pref_change'] = Slack::RealTime::EventHandlers::TeamPrefChange
