module Slack
  module RealTime
    module EventHandlers
      module ChannelLeft
        # You left a channel.
        # @see https://api.slack.com/events/channel_left
        # @see https://github.com/dblock/slack-api-ref/blob/master/events/channel_left.json
        def self.call(client, data)
          channel = client.channels[data.channel]
          channel.members.delete(client.self.id) if channel.key?('members')
        end
      end
    end
  end
end

Slack::RealTime::Client.events['channel_left'] = Slack::RealTime::EventHandlers::ChannelLeft
