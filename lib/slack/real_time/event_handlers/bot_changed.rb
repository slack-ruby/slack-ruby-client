module Slack
  module RealTime
    module EventHandlers
      module BotChanged
        # An integration bot was changed.
        # @see https://api.slack.com/events/bot_changed
        # @see https://github.com/dblock/slack-api-ref/blob/master/events/bot_changed.json
        def self.call(client, data)
          bot = client.bots[data.bot.id]
          bot.merge!(data.bot) if bot
        end
      end
    end
  end
end

Slack::RealTime::Client.events['bot_changed'] = Slack::RealTime::EventHandlers::BotChanged
