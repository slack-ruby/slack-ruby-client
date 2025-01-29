# frozen_string_literal: true
# This file was auto-generated by lib/tasks/web.rake

module Slack
  module Web
    module Api
      module Endpoints
        module AdminUsersSession
          #
          # Clear user-specific session settings—the session duration and what happens when the client closes—for a list of users.
          #
          # @option options [array] :user_ids
          #   The IDs of users you'd like to clear session settings for.
          # @see https://api.slack.com/methods/admin.users.session.clearSettings
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/admin.users.session/admin.users.session.clearSettings.json
          def admin_users_session_clearSettings(options = {})
            raise ArgumentError, 'Required arguments :user_ids missing' if options[:user_ids].nil?
            post('admin.users.session.clearSettings', options)
          end

          #
          # Get user-specific session settings—the session duration and what happens when the client closes—given a list of users.
          #
          # @option options [array] :user_ids
          #   The IDs of users you'd like to fetch session settings for. Note: if a user does not have any active sessions, they will not be returned in the response.
          # @see https://api.slack.com/methods/admin.users.session.getSettings
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/admin.users.session/admin.users.session.getSettings.json
          def admin_users_session_getSettings(options = {})
            raise ArgumentError, 'Required arguments :user_ids missing' if options[:user_ids].nil?
            post('admin.users.session.getSettings', options)
          end

          #
          # Revoke a single session for a user. The user will be forced to login to Slack.
          #
          # @option options [integer] :session_id
          #   ID of the session to invalidate.
          # @option options [Object] :user_id
          #   ID of the user that the session belongs to.
          # @see https://api.slack.com/methods/admin.users.session.invalidate
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/admin.users.session/admin.users.session.invalidate.json
          def admin_users_session_invalidate(options = {})
            raise ArgumentError, 'Required arguments :session_id missing' if options[:session_id].nil?
            post('admin.users.session.invalidate', options)
          end

          #
          # List active user sessions for an organization
          #
          # @option options [string] :cursor
          #   Set cursor to next_cursor returned by the previous call to list items in the next page.
          # @option options [integer] :limit
          #   The maximum number of items to return. Must be between 1 - 1000 both inclusive.
          # @option options [string] :team_id
          #   The ID of the workspace you'd like active sessions for. If you pass a team_id, you'll need to pass a user_id as well.
          # @option options [string] :user_id
          #   The ID of user you'd like active sessions for. If you pass a user_id, you'll need to pass a team_id as well.
          # @see https://api.slack.com/methods/admin.users.session.list
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/admin.users.session/admin.users.session.list.json
          def admin_users_session_list(options = {})
            if block_given?
              Pagination::Cursor.new(self, :admin_users_session_list, options).each do |page|
                yield page
              end
            else
              post('admin.users.session.list', options)
            end
          end

          #
          # Wipes all valid sessions on all devices for a given user
          #
          # @option options [string] :user_id
          #   The ID of the user to wipe sessions for.
          # @option options [boolean] :mobile_only
          #   Only expire mobile sessions (default: false).
          # @option options [boolean] :web_only
          #   Only expire web sessions (default: false).
          # @see https://api.slack.com/methods/admin.users.session.reset
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/admin.users.session/admin.users.session.reset.json
          def admin_users_session_reset(options = {})
            raise ArgumentError, 'Required arguments :user_id missing' if options[:user_id].nil?
            post('admin.users.session.reset', options)
          end

          #
          # Enqueues an asynchronous job to wipe all valid sessions on all devices for a given list of users
          #
          # @option options [array] :user_ids
          #   The ID of the user to wipe sessions for.
          # @option options [boolean] :mobile_only
          #   Only expire mobile sessions (default: false).
          # @option options [boolean] :web_only
          #   Only expire web sessions (default: false).
          # @see https://api.slack.com/methods/admin.users.session.resetBulk
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/admin.users.session/admin.users.session.resetBulk.json
          def admin_users_session_resetBulk(options = {})
            raise ArgumentError, 'Required arguments :user_ids missing' if options[:user_ids].nil?
            post('admin.users.session.resetBulk', options)
          end

          #
          # Configure the user-level session settings—the session duration and what happens when the client closes—for one or more users.
          #
          # @option options [array] :user_ids
          #   The list of up to 1,000 user IDs to apply the session settings for.
          # @option options [boolean] :desktop_app_browser_quit
          #   Terminate the session when the client—either the desktop app or a browser window—is closed.
          # @option options [integer] :duration
          #   The session duration, in seconds. The minimum value is 28800, which represents 8 hours; the max value is 315569520 or 10 years (that's a long Slack session).
          # @see https://api.slack.com/methods/admin.users.session.setSettings
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/admin.users.session/admin.users.session.setSettings.json
          def admin_users_session_setSettings(options = {})
            raise ArgumentError, 'Required arguments :user_ids missing' if options[:user_ids].nil?
            post('admin.users.session.setSettings', options)
          end
        end
      end
    end
  end
end
