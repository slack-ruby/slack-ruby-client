module Slack
  module RealTime
    module EventHandlers
      module ChannelRename
        # A team channel was renamed.
        # @see https://api.slack.com/events/channel_rename
        # @see https://github.com/dblock/slack-api-ref/blob/master/events/channel_rename.json
        def self.call(client, data)
          channel = client.channels[data.channel.id]
          channel.name = data.channel.name if channel
        end
      end
    end
  end
end

Slack::RealTime::Client.events['channel_rename'] = Slack::RealTime::EventHandlers::ChannelRename
