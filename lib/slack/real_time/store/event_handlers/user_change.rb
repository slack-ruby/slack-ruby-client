module Slack
  module RealTime
    module Store
      module Handlers
        module UserChange
          # A team member's data has changed.
          # @see https://api.slack.com/events/user_change
          # @see https://github.com/dblock/slack-api-ref/blob/master/events/user_change.json
          def self.call(client, data)
            client.users[data['user']['id']] = Models::User.new(data['user'])
          end
        end
      end
    end
  end
end

Slack::RealTime::Client.events['user_change'] = Slack::RealTime::Store::Handlers::UserChange
