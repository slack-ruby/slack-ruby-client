# frozen_string_literal: true
require_relative 'ids.id'

module Slack
  module Web
    module Api
      module Mixins
        module Users
          include Ids
          #
          # This method returns a user ID given a user name.
          #
          # @option options [user] :user
          #   User to get ID for, prefixed with '@'.
          # @option options [integer] :id_limit
          #   The page size used for users_list calls required to find the user's ID
          def users_id(options = {})
            name = options[:user]
            limit = options.fetch(:id_limit, Slack::Web.config.users_id_page_size)

            raise ArgumentError, 'Required arguments :user missing' if name.nil?

            id_for(
              key: :user,
              name: name,
              prefix: '@',
              enum_method: :users_list,
              list_method: :members,
              options: { limit: limit }.compact
            )
          end
        end
      end
    end
  end
end
