module Slack
  module RealTime
    module EventHandlers
      module GroupClose
        # You closed a group channel.
        # @see https://api.slack.com/events/group_close
        # @see https://github.com/dblock/slack-api-ref/blob/master/events/group_close.json
        def self.call(client, data)
          client.groups[data.channel].is_open = false
        end
      end
    end
  end
end

Slack::RealTime::Client.events['group_close'] = Slack::RealTime::EventHandlers::GroupClose
