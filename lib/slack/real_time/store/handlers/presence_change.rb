module Slack
  module RealTime
    module Store
      module Handlers
        module PresenceChange
          def self.call(client, data)
            client.users[data['user']]['presence'] = data['presence']
          end
        end
      end
    end
  end
end

Slack::RealTime::Client.events['presence_change'] = Slack::RealTime::Store::Handlers::PresenceChange
