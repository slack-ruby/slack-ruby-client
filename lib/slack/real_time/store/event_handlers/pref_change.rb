module Slack
  module RealTime
    module Store
      module Handlers
        module PrefChange
          # You have updated your preferences.
          # @see https://api.slack.com/events/pref_change
          # @see https://github.com/dblock/slack-api-ref/blob/master/events/pref_change.json
          def self.call(client, data)
            client.self['prefs'][data['name']] = data['value']
          end
        end
      end
    end
  end
end

Slack::RealTime::Client.events['pref_change'] = Slack::RealTime::Store::Handlers::PrefChange
