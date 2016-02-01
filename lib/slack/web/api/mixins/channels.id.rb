module Slack
  module Web
    module Api
      module Mixins
        module Channels
          #
          # This method returns a channel ID given a channel name.
          #
          # @option options [channel] :channel
          #   Channel to get ID for, prefixed with #.
          def channels_id(options = {})
            name = options[:channel]
            throw ArgumentError.new('Required arguments :channel missing') if name.nil?
            return { 'ok' => true, 'channel' => { 'id' => name } } unless name[0] == '#'
            channels_list.tap do |list|
              list.channels.each do |channel|
                return Slack::Messages::Message.new('ok' => true, 'channel' => { 'id' => channel.id }) if channel.name == name[1..-1]
              end
            end
            fail Slack::Web::Api::Error, 'channel_not_found'
          end
        end
      end
    end
  end
end
