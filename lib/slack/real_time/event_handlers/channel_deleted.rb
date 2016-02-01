module Slack
  module RealTime
    module EventHandlers
      module ChannelDeleted
        # A team channel was deleted.
        # @see https://api.slack.com/events/channel_deleted
        # @see https://github.com/dblock/slack-api-ref/blob/master/events/channel_deleted.json
        def self.call(client, data)
          client.channels.delete(data.channel)
        end
      end
    end
  end
end

Slack::RealTime::Client.events['channel_deleted'] = Slack::RealTime::EventHandlers::ChannelDeleted
