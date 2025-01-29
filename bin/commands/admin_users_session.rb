# frozen_string_literal: true
# This file was auto-generated by lib/tasks/web.rake

module Slack
  module Cli
    class App
      desc 'AdminUsersSession methods.'
      command 'admin_users_session' do |g|
        g.desc 'Clear user-specific session settings—the session duration and what happens when the client closes—for a list of users.'
        g.long_desc %( Clear user-specific session settings—the session duration and what happens when the client closes—for a list of users. )
        g.command 'clearSettings' do |c|
          c.flag 'user_ids', desc: "The IDs of users you'd like to clear session settings for."
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.admin_users_session_clearSettings(options))
          end
        end

        g.desc 'Get user-specific session settings—the session duration and what happens when the client closes—given a list of users.'
        g.long_desc %( Get user-specific session settings—the session duration and what happens when the client closes—given a list of users. )
        g.command 'getSettings' do |c|
          c.flag 'user_ids', desc: "The IDs of users you'd like to fetch session settings for. Note: if a user does not have any active sessions, they will not be returned in the response."
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.admin_users_session_getSettings(options))
          end
        end

        g.desc 'Revoke a single session for a user. The user will be forced to login to Slack.'
        g.long_desc %( Revoke a single session for a user. The user will be forced to login to Slack. )
        g.command 'invalidate' do |c|
          c.flag 'session_id', desc: 'ID of the session to invalidate.'
          c.flag 'user_id', desc: 'ID of the user that the session belongs to.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.admin_users_session_invalidate(options))
          end
        end

        g.desc 'List active user sessions for an organization'
        g.long_desc %( List active user sessions for an organization )
        g.command 'list' do |c|
          c.flag 'cursor', desc: 'Set cursor to next_cursor returned by the previous call to list items in the next page.'
          c.flag 'limit', desc: 'The maximum number of items to return. Must be between 1 - 1000 both inclusive.'
          c.flag 'team_id', desc: "The ID of the workspace you'd like active sessions for. If you pass a team_id, you'll need to pass a user_id as well."
          c.flag 'user_id', desc: "The ID of user you'd like active sessions for. If you pass a user_id, you'll need to pass a team_id as well."
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.admin_users_session_list(options))
          end
        end

        g.desc 'Wipes all valid sessions on all devices for a given user'
        g.long_desc %( Wipes all valid sessions on all devices for a given user )
        g.command 'reset' do |c|
          c.flag 'user_id', desc: 'The ID of the user to wipe sessions for.'
          c.flag 'mobile_only', desc: 'Only expire mobile sessions (default: false).'
          c.flag 'web_only', desc: 'Only expire web sessions (default: false).'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.admin_users_session_reset(options))
          end
        end

        g.desc 'Enqueues an asynchronous job to wipe all valid sessions on all devices for a given list of users'
        g.long_desc %( Enqueues an asynchronous job to wipe all valid sessions on all devices for a given list of users )
        g.command 'resetBulk' do |c|
          c.flag 'user_ids', desc: 'The ID of the user to wipe sessions for.'
          c.flag 'mobile_only', desc: 'Only expire mobile sessions (default: false).'
          c.flag 'web_only', desc: 'Only expire web sessions (default: false).'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.admin_users_session_resetBulk(options))
          end
        end

        g.desc 'Configure the user-level session settings—the session duration and what happens when the client closes—for one or more users.'
        g.long_desc %( Configure the user-level session settings—the session duration and what happens when the client closes—for one or more users. )
        g.command 'setSettings' do |c|
          c.flag 'user_ids', desc: 'The list of up to 1,000 user IDs to apply the session settings for.'
          c.flag 'desktop_app_browser_quit', desc: 'Terminate the session when the client—either the desktop app or a browser window—is closed.'
          c.flag 'duration', desc: "The session duration, in seconds. The minimum value is 28800, which represents 8 hours; the max value is 315569520 or 10 years (that's a long Slack session)."
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.admin_users_session_setSettings(options))
          end
        end
      end
    end
  end
end
