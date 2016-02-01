module Slack
  module RealTime
    module EventHandlers
      module TeamDomainChange
        # The team domain has changed.
        # @see https://api.slack.com/events/team_domain_change
        # @see https://github.com/dblock/slack-api-ref/blob/master/events/team_domain_change.json
        def self.call(client, data)
          client.team['url'] = data['url']
          client.team['domain'] = data['domain']
        end
      end
    end
  end
end

Slack::RealTime::Client.events['team_domain_change'] = Slack::RealTime::EventHandlers::TeamDomainChange
