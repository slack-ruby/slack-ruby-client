module Slack
  module RealTime
    module Store
      module Handlers
        module PrefChange
          def self.call(client, data)
            client.self['prefs'][data['name']] = data['value']
          end
        end
      end
    end
  end
end

Slack::RealTime::Client.events['pref_change'] = Slack::RealTime::Store::Handlers::PrefChange
