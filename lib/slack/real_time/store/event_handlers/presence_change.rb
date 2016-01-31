module Slack
  module RealTime
    module Store
      module Handlers
        module PresenceChange
          # A team member's presence changed.
          # @see https://api.slack.com/events/presence_change
          # @see https://github.com/dblock/slack-api-ref/blob/master/events/presence_change.json
          def self.call(client, data)
            client.users[data['user']]['presence'] = data['presence']
          end
        end
      end
    end
  end
end

Slack::RealTime::Client.events['presence_change'] = Slack::RealTime::Store::Handlers::PresenceChange
