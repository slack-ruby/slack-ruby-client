module Slack
  module RealTime
    module EventHandlers
      module GroupRename
        # A private group was renamed.
        # @see https://api.slack.com/events/group_rename
        # @see https://github.com/dblock/slack-api-ref/blob/master/events/group_rename.json
        def self.call(client, data)
          channel = client.groups[data['channel']['id']]
          channel['name'] = data['channel']['name'] if channel
        end
      end
    end
  end
end

Slack::RealTime::Client.events['group_rename'] = Slack::RealTime::EventHandlers::GroupRename
