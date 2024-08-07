# frozen_string_literal: true
# This file was auto-generated by lib/tasks/web.rake

module Slack
  module Web
    module Api
      module Endpoints
        module UsersDiscoverablecontacts
          #
          # Look up an email address to see if someone is discoverable on Slack
          #
          # @option options [string] :email
          #   .
          # @see https://api.slack.com/methods/users.discoverableContacts.lookup
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/users.discoverableContacts/users.discoverableContacts.lookup.json
          def users_discoverableContacts_lookup(options = {})
            raise ArgumentError, 'Required arguments :email missing' if options[:email].nil?
            post('users.discoverableContacts.lookup', options)
          end
        end
      end
    end
  end
end
