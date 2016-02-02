module Slack
  module RealTime
    module EventHandlers
      module ImCreated
        # A direct message channel was created.
        # @see https://api.slack.com/events/im_created
        # @see https://github.com/dblock/slack-api-ref/blob/master/events/im_created.json
        def self.call(client, data)
          client.ims[data.channel.id] = Models::Im.new(data.channel)
        end
      end
    end
  end
end

Slack::RealTime::Client.events['im_created'] = Slack::RealTime::EventHandlers::ImCreated
