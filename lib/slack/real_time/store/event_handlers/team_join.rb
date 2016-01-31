module Slack
  module RealTime
    module Store
      module Handlers
        module TeamJoin
          # A new team member has joined.
          # @see https://api.slack.com/events/team_join
          # @see https://github.com/dblock/slack-api-ref/blob/master/events/team_join.json
          def self.call(client, data)
            client.users[data['user']['id']] = Models::User.new(data['user'])
          end
        end
      end
    end
  end
end

Slack::RealTime::Client.events['team_join'] = Slack::RealTime::Store::Handlers::TeamJoin
