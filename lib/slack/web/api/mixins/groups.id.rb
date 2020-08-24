# frozen_string_literal: true
require_relative 'ids.id'

module Slack
  module Web
    module Api
      module Mixins
        module Groups
          include Ids
          #
          # This method returns a group ID given a group name.
          #
          # @option options [channel] :channel
          #   Group channel to get ID for, prefixed with #.
          def groups_id(options = {})
            name = options[:channel]
            throw ArgumentError.new('Required arguments :channel missing') if name.nil?

            id_for :group, name, '#', :groups_list, :groups, 'channel_not_found'
          end
        end
      end
    end
  end
end
