module Slack
  module RealTime
    module EventHandlers
      module TeamRename
        # The team name has changed.
        # @see https://api.slack.com/events/team_rename
        # @see https://github.com/dblock/slack-api-ref/blob/master/events/team_rename.json
        def self.call(client, data)
          client.team['name'] = data['name']
        end
      end
    end
  end
end

Slack::RealTime::Client.events['team_rename'] = Slack::RealTime::EventHandlers::TeamRename
