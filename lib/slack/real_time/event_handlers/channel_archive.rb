module Slack
  module RealTime
    module EventHandlers
      module ChannelArchive
        # A team channel was archived.
        # @see https://api.slack.com/events/channel_archive
        # @see https://github.com/dblock/slack-api-ref/blob/master/events/channel_archive.json
        def self.call(client, data)
          channel = client.channels[data.channel]
          channel.is_archived = true if channel
        end
      end
    end
  end
end

Slack::RealTime::Client.events['channel_archive'] = Slack::RealTime::EventHandlers::ChannelArchive
