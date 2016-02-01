module Slack
  module RealTime
    module EventHandlers
      module BotAdded
        # An integration bot was added.
        # @see https://api.slack.com/events/bot_added
        # @see https://github.com/dblock/slack-api-ref/blob/master/events/bot_added.json
        def self.call(client, data)
          client.bots[data.bot.id] = Models::Bot.new(data.bot)
        end
      end
    end
  end
end

Slack::RealTime::Client.events['bot_added'] = Slack::RealTime::EventHandlers::BotAdded
