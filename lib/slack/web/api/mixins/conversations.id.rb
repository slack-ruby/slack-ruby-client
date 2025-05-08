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
          # @option options [integer] :limit
          #   The page size used for conversations_list calls required to find the channel's ID
          def conversations_id(options = {})
            name = options[:channel]
            limit = options.fetch(:limit, conversations_id_page_size)

            raise ArgumentError, 'Required arguments :channel missing' if name.nil?

            id_for(
              :channel,
              name,
              '#',
              :conversations_list,
              :channels,
              'channel_not_found',
              enum_method_options: { limit: limit }
            )
          end
        end
      end
    end
  end
end
