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
          # @option options [integer] :limit
          #   The page size used for users_list calls required to find the user's ID
          def users_id(options = {})
            name = options[:user]
            limit = options.fetch(:limit, users_id_page_size)

            raise ArgumentError, 'Required arguments :user missing' if name.nil?

            id_for(
              :user,
              name,
              '@',
              :users_list,
              :members,
              'user_not_found',
              enum_method_options: { limit: limit }
            )
          end
        end
      end
    end
  end
end
