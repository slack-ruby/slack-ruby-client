module Slack
  module RealTime
    module EventHandlers
      module GroupArchive
        # A private group was archived.
        # @see https://api.slack.com/events/group_archive
        # @see https://github.com/dblock/slack-api-ref/blob/master/events/group_archive.json
        def self.call(client, data)
          channel = client.groups[data['channel']]
          channel['is_archived'] = true if channel
        end
      end
    end
  end
end

Slack::RealTime::Client.events['group_archive'] = Slack::RealTime::EventHandlers::GroupArchive
