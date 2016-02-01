module Slack
  module RealTime
    module EventHandlers
      module GroupJoined
        # You joined a private group.
        # @see https://api.slack.com/events/group_joined
        # @see https://github.com/dblock/slack-api-ref/blob/master/events/group_joined.json
        def self.call(client, data)
          channel_id = data['channel']['id']
          channel = client.groups[channel_id]
          if channel
            channel.merge!(data['channel'])
          else
            client.groups[channel_id] = Models::Channel.new(data['channel'])
          end
        end
      end
    end
  end
end

Slack::RealTime::Client.events['group_joined'] = Slack::RealTime::EventHandlers::GroupJoined
