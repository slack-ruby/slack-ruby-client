module Slack
  module RealTime
    module EventHandlers
      module ChannelJoined
        # You joined a channel.
        # @see https://api.slack.com/events/channel_joined
        # @see https://github.com/dblock/slack-api-ref/blob/master/events/channel_joined.json
        def self.call(client, data)
          channel_id = data['channel']['id']
          channel = client.channels[channel_id]
          if channel
            channel.merge!(data['channel'])
          else
            client.channels[channel_id] = Models::Channel.new(data['channel'])
          end
        end
      end
    end
  end
end

Slack::RealTime::Client.events['channel_joined'] = Slack::RealTime::EventHandlers::ChannelJoined
