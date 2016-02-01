module Slack
  module RealTime
    module EventHandlers
      module EmailDomainChanged
        # The team email domain has changed.
        # @see https://api.slack.com/events/email_domain_changed
        # @see https://github.com/dblock/slack-api-ref/blob/master/events/email_domain_changed.json
        def self.call(client, data)
          client.team.email_domain = data.email_domain
        end
      end
    end
  end
end

Slack::RealTime::Client.events['email_domain_changed'] = Slack::RealTime::EventHandlers::EmailDomainChanged
