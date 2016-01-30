module Slack
  module RealTime
    module Store
      module Handlers
        module UserChange
          def self.call(client, data)
            client.users[data['user']['id']] = Models::User.new(data['user'])
          end
        end
      end
    end
  end
end

Slack::RealTime::Client.events['user_change'] = Slack::RealTime::Store::Handlers::UserChange
