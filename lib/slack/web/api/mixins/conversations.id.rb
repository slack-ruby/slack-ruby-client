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
          # @option options [integer] :id_limit
          #   The page size used for conversations_list calls required to find the channel's ID
          # @option options [string] :id_types
          #   The types of conversations to use when searching for the ID. A comma-separated list
          #   containing one or more of public_channel, private_channel, mpim, im
          def conversations_id(options = {})
            name = options[:channel]
            limit = options.fetch(:id_limit, Slack::Web.config.conversations_id_page_size)
            types = options.fetch(:id_types, nil)

            raise ArgumentError, 'Required arguments :channel missing' if name.nil?

            id_for(
              key: :channel,
              name: name,
              prefix: '#',
              enum_method: :conversations_list,
              list_method: :channels,
              options: { limit: limit, types: types }.compact
            )
          end
        end
      end
    end
  end
end
