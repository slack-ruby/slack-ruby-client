module Slack
  module RealTime
    module Store
      module Handlers
        module ManualPresenceChange
          def self.call(client, data)
            client.self['presence'] = data['presence']
          end
        end
      end
    end
  end
end

Slack::RealTime::Client.events['manual_presence_change'] = Slack::RealTime::Store::Handlers::ManualPresenceChange
