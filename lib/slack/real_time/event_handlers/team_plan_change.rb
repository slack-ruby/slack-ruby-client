module Slack
  module RealTime
    module EventHandlers
      module TeamPlanChange
        # The team billing plan has changed.
        # @see https://api.slack.com/events/team_plan_change
        # @see https://github.com/dblock/slack-api-ref/blob/master/events/team_plan_change.json
        def self.call(client, data)
          client.team['plan'] = data['plan']
        end
      end
    end
  end
end

Slack::RealTime::Client.events['team_plan_change'] = Slack::RealTime::EventHandlers::TeamPlanChange
