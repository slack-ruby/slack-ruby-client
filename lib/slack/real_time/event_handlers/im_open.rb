module Slack
  module RealTime
    module EventHandlers
      module ImOpen
        # You opened a direct message channel.
        # @see https://api.slack.com/events/im_open
        # @see https://github.com/dblock/slack-api-ref/blob/master/events/im_open.json
        def self.call(client, data)
          client.ims[data.channel].is_open = true
        end
      end
    end
  end
end

Slack::RealTime::Client.events['im_open'] = Slack::RealTime::EventHandlers::ImOpen
