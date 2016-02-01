module Slack
  module RealTime
    module EventHandlers
      module ChannelCreated
        # A team channel was created.
        # @see https://api.slack.com/events/channel_created
        # @see https://github.com/dblock/slack-api-ref/blob/master/events/channel_created.json
        def self.call(client, data)
          channel = Models::Channel.new(data['channel'])
          client.channels[channel['id']] = channel
        end
      end
    end
  end
end

Slack::RealTime::Client.events['channel_created'] = Slack::RealTime::EventHandlers::ChannelCreated
