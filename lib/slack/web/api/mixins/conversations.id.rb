# frozen_string_literal: true
require_relative 'ids.id'

module Slack
  module Web
    module Api
      module Mixins
        module Conversations
          include Ids
          #
          # This method returns a channel ID given a channel name.
          #
          # @option options [channel] :channel
          #   Channel to get ID for, prefixed with #.
          def conversations_id(options = {})
            name = options[:channel]
            raise ArgumentError, 'Required arguments :channel missing' if name.nil?

            id_for(
              :channel,
              name,
              '#',
              :conversations_list,
              :channels,
              'channel_not_found',
              enum_method_options: { limit: conversations_id_page_size }
            )
          end
        end
      end
    end
  end
end
