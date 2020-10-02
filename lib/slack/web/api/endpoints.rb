# frozen_string_literal: true
# This file was auto-generated by lib/tasks/web.rake

require_relative 'endpoints/admin_apps'
require_relative 'endpoints/admin_apps_approved'
require_relative 'endpoints/admin_apps_requests'
require_relative 'endpoints/admin_apps_restricted'
require_relative 'endpoints/admin_conversations'
require_relative 'endpoints/admin_conversations_ekm'
require_relative 'endpoints/admin_conversations_restrictAccess'
require_relative 'endpoints/admin_conversations_whitelist'
require_relative 'endpoints/admin_emoji'
require_relative 'endpoints/admin_inviteRequests'
require_relative 'endpoints/admin_inviteRequests_approved'
require_relative 'endpoints/admin_inviteRequests_denied'
require_relative 'endpoints/admin_teams'
require_relative 'endpoints/admin_teams_admins'
require_relative 'endpoints/admin_teams_owners'
require_relative 'endpoints/admin_teams_settings'
require_relative 'endpoints/admin_usergroups'
require_relative 'endpoints/admin_users'
require_relative 'endpoints/admin_users_session'
require_relative 'endpoints/api'
require_relative 'endpoints/apps'
require_relative 'endpoints/apps_event_authorizations'
require_relative 'endpoints/apps_permissions'
require_relative 'endpoints/apps_permissions_resources'
require_relative 'endpoints/apps_permissions_scopes'
require_relative 'endpoints/apps_permissions_users'
require_relative 'endpoints/auth'
require_relative 'endpoints/bots'
require_relative 'endpoints/calls'
require_relative 'endpoints/calls_participants'
require_relative 'endpoints/channels'
require_relative 'endpoints/chat'
require_relative 'endpoints/chat_scheduledMessages'
require_relative 'endpoints/conversations'
require_relative 'endpoints/dialog'
require_relative 'endpoints/dnd'
require_relative 'endpoints/emoji'
require_relative 'endpoints/files'
require_relative 'endpoints/files_comments'
require_relative 'endpoints/files_remote'
require_relative 'endpoints/groups'
require_relative 'endpoints/im'
require_relative 'endpoints/migration'
require_relative 'endpoints/mpim'
require_relative 'endpoints/oauth'
require_relative 'endpoints/oauth_v2'
require_relative 'endpoints/pins'
require_relative 'endpoints/reactions'
require_relative 'endpoints/reminders'
require_relative 'endpoints/rtm'
require_relative 'endpoints/search'
require_relative 'endpoints/stars'
require_relative 'endpoints/team'
require_relative 'endpoints/team_profile'
require_relative 'endpoints/usergroups'
require_relative 'endpoints/usergroups_users'
require_relative 'endpoints/users'
require_relative 'endpoints/users_admin'
require_relative 'endpoints/users_prefs'
require_relative 'endpoints/users_profile'
require_relative 'endpoints/views'
require_relative 'endpoints/workflows'

module Slack
  module Web
    module Api
      module Endpoints
        include Slack::Web::Api::Mixins::Channels
        include Slack::Web::Api::Mixins::Users
        include Slack::Web::Api::Mixins::Groups

        include AdminApps
        include AdminAppsApproved
        include AdminAppsRequests
        include AdminAppsRestricted
        include AdminConversations
        include AdminConversationsEkm
        include AdminConversationsRestrictaccess
        include AdminConversationsWhitelist
        include AdminEmoji
        include AdminInviterequests
        include AdminInviterequestsApproved
        include AdminInviterequestsDenied
        include AdminTeams
        include AdminTeamsAdmins
        include AdminTeamsOwners
        include AdminTeamsSettings
        include AdminUsergroups
        include AdminUsers
        include AdminUsersSession
        include Api
        include Apps
        include AppsEventAuthorizations
        include AppsPermissions
        include AppsPermissionsResources
        include AppsPermissionsScopes
        include AppsPermissionsUsers
        include Auth
        include Bots
        include Calls
        include CallsParticipants
        include Channels
        include Chat
        include ChatScheduledmessages
        include Conversations
        include Dialog
        include Dnd
        include Emoji
        include Files
        include FilesComments
        include FilesRemote
        include Groups
        include Im
        include Migration
        include Mpim
        include Oauth
        include OauthV2
        include Pins
        include Reactions
        include Reminders
        include Rtm
        include Search
        include Stars
        include Team
        include TeamProfile
        include Usergroups
        include UsergroupsUsers
        include Users
        include UsersAdmin
        include UsersPrefs
        include UsersProfile
        include Views
        include Workflows
      end
    end
  end
end
