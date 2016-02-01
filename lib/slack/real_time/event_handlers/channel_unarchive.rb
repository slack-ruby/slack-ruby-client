module Slack
  module RealTime
    module EventHandlers
      module ChannelUnarchive
        # A team channel was unarchived.
        # @see https://api.slack.com/events/channel_unarchive
        # @see https://github.com/dblock/slack-api-ref/blob/master/events/channel_unarchive.json
        def self.call(client, data)
          channel = client.channels[data['channel']]
          channel['is_archived'] = false if channel
        end
      end
    end
  end
end

Slack::RealTime::Client.events['channel_unarchive'] = Slack::RealTime::EventHandlers::ChannelUnarchive
