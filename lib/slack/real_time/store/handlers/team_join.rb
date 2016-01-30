module Slack
  module RealTime
    module Store
      module Handlers
        module TeamJoin
          def self.call(client, data)
            client.users[data['user']['id']] = Models::User.new(data['user'])
          end
        end
      end
    end
  end
end

Slack::RealTime::Client.events['team_join'] = Slack::RealTime::Store::Handlers::TeamJoin
