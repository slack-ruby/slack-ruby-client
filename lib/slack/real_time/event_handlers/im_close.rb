module Slack
  module RealTime
    module EventHandlers
      module ImClose
        # You closed a direct message channel.
        # @see https://api.slack.com/events/im_close
        # @see https://github.com/dblock/slack-api-ref/blob/master/events/im_close.json
        def self.call(client, data)
          client.ims[data.channel].is_open = false
        end
      end
    end
  end
end

Slack::RealTime::Client.events['im_close'] = Slack::RealTime::EventHandlers::ImClose
