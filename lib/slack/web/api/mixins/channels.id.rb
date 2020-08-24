# frozen_string_literal: true
require_relative 'ids.id'

module Slack
  module Web
    module Api
      module Mixins
        module Channels
          include Ids
          #
          # This method returns a channel ID given a channel name.
          #
          # @option options [channel] :channel
          #   Channel to get ID for, prefixed with #.
          def channels_id(options = {})
            name = options[:channel]
            throw ArgumentError.new('Required arguments :channel missing') if name.nil?

            id_for :channel, name, '#', :channels_list, :channels, 'channel_not_found'
          end
        end
      end
    end
  end
end
