# frozen_string_literal: true

module Slack
  module RealTime
    module Stores
      # Stores only basic team and self info
      class Starter < Base
        attr_reader :self, :team

        def initialize(attrs, _options = {})
          @team = Models::Team.new(attrs.team)
          @self = Models::User.new(attrs.self)
        end

        ### RealTime Events

        # The list of accounts a user is signed into has changed.
        # @see https://api.slack.com/events/accounts_changed
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/accounts_changed.json
        # on :accounts_changed do |data|

        # User has deleted an app.
        # @see https://api.slack.com/events/app_deleted
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/app_deleted.json
        # on :app_deleted do |data|

        # User clicked into your App Home.
        # @see https://api.slack.com/events/app_home_opened
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/app_home_opened.json
        # on :app_home_opened do |data|

        # User has installed an app.
        # @see https://api.slack.com/events/app_installed
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/app_installed.json
        # on :app_installed do |data|

        # Subscribe to only the message events that mention your app or bot.
        # @see https://api.slack.com/events/app_mention
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/app_mention.json
        # on :app_mention do |data|

        # Indicates your app's event subscriptions are being rate limited.
        # @see https://api.slack.com/events/app_rate_limited
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/app_rate_limited.json
        # on :app_rate_limited do |data|

        # User requested an app.
        # @see https://api.slack.com/events/app_requested
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/app_requested.json
        # on :app_requested do |data|

        # Your Slack app was uninstalled.
        # @see https://api.slack.com/events/app_uninstalled
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/app_uninstalled.json
        # on :app_uninstalled do |data|

        # User has uninstalled an app.
        # @see https://api.slack.com/events/app_uninstalled_team
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/app_uninstalled_team.json
        # on :app_uninstalled_team do |data|

        # The message sent is an app assistant thread..
        # @see https://api.slack.com/events/assistant_app_thread
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/assistant_app_thread.json
        # on :assistant_app_thread do |data|

        # The context changed while an AI assistant thread was visible.
        # @see https://api.slack.com/events/assistant_thread_context_changed
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/assistant_thread_context_changed.json
        # on :assistant_thread_context_changed do |data|

        # An AI assistant thread was started.
        # @see https://api.slack.com/events/assistant_thread_started
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/assistant_thread_started.json
        # on :assistant_thread_started do |data|

        # A bot user was added.
        # @see https://api.slack.com/events/bot_added
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/bot_added.json
        # on :bot_added do |data|

        # A bot user was changed.
        # @see https://api.slack.com/events/bot_changed
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/bot_changed.json
        # on :bot_changed do |data|

        # A message was posted by an integration.
        # @see https://api.slack.com/events/bot_message
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/bot_message.json
        # on :bot_message do |data|

        # A call was rejected.
        # @see https://api.slack.com/events/call_rejected
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/call_rejected.json
        # on :call_rejected do |data|

        # A channel was archived.
        # @see https://api.slack.com/events/channel_archive
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/channel_archive.json
        # on :channel_archive do |data|

        # This channel was made private; now it can only be viewed or joined by invitation.
        # @see https://api.slack.com/events/channel_convert_to_private
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/channel_convert_to_private.json
        # on :channel_convert_to_private do |data|

        # This channel was made public; now any member in this workspace can see and join it.
        # @see https://api.slack.com/events/channel_convert_to_public
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/channel_convert_to_public.json
        # on :channel_convert_to_public do |data|

        # A channel was created.
        # @see https://api.slack.com/events/channel_created
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/channel_created.json
        # on :channel_created do |data|

        # A channel was deleted.
        # @see https://api.slack.com/events/channel_deleted
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/channel_deleted.json
        # on :channel_deleted do |data|

        # Bulk updates were made to a channel's history.
        # @see https://api.slack.com/events/channel_history_changed
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/channel_history_changed.json
        # on :channel_history_changed do |data|

        # A channel ID changed.
        # @see https://api.slack.com/events/channel_id_changed
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/channel_id_changed.json
        # on :channel_id_changed do |data|

        # You joined a channel.
        # @see https://api.slack.com/events/channel_joined
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/channel_joined.json
        # on :channel_joined do |data|

        # A member left a channel.
        # @see https://api.slack.com/events/channel_leave
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/channel_leave.json
        # on :channel_leave do |data|

        # You left a channel.
        # @see https://api.slack.com/events/channel_left
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/channel_left.json
        # on :channel_left do |data|

        # Your channel read marker was updated.
        # @see https://api.slack.com/events/channel_marked
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/channel_marked.json
        # on :channel_marked do |data|

        # A channel was renamed.
        # @see https://api.slack.com/events/channel_name
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/channel_name.json
        # on :channel_name do |data|

        # The posting permissions for a channel changed.
        # @see https://api.slack.com/events/channel_posting_permissions
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/channel_posting_permissions.json
        # on :channel_posting_permissions do |data|

        # A channel purpose was updated.
        # @see https://api.slack.com/events/channel_purpose
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/channel_purpose.json
        # on :channel_purpose do |data|

        # A channel was renamed.
        # @see https://api.slack.com/events/channel_rename
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/channel_rename.json
        # on :channel_rename do |data|

        # A channel has been shared with an external workspace.
        # @see https://api.slack.com/events/channel_shared
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/channel_shared.json
        # on :channel_shared do |data|

        # A channel topic was updated.
        # @see https://api.slack.com/events/channel_topic
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/channel_topic.json
        # on :channel_topic do |data|

        # A channel was unarchived.
        # @see https://api.slack.com/events/channel_unarchive
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/channel_unarchive.json
        # on :channel_unarchive do |data|

        # A channel has been unshared with an external workspace.
        # @see https://api.slack.com/events/channel_unshared
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/channel_unshared.json
        # on :channel_unshared do |data|

        # A slash command has been added or changed.
        # @see https://api.slack.com/events/commands_changed
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/commands_changed.json
        # on :commands_changed do |data|

        # Do not Disturb settings changed for the current user.
        # @see https://api.slack.com/events/dnd_updated
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/dnd_updated.json
        # on :dnd_updated do |data|

        # Do not Disturb settings changed for a member.
        # @see https://api.slack.com/events/dnd_updated_user
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/dnd_updated_user.json
        # on :dnd_updated_user do |data|

        # A bot is mentioned in the body of a canvas.
        # @see https://api.slack.com/events/document_mention
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/document_mention.json
        # on :document_mention do |data|

        # Message content redacted due to Enterprise Key Management (EKM).
        # @see https://api.slack.com/events/ekm_access_denied
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/ekm_access_denied.json
        # on :ekm_access_denied do |data|

        # The workspace email domain has changed.
        # @see https://api.slack.com/events/email_domain_changed
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/email_domain_changed.json
        on :email_domain_changed do |data|
          team.email_domain = data.email_domain
        end

        # A custom emoji has been added or changed.
        # @see https://api.slack.com/events/emoji_changed
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/emoji_changed.json
        # on :emoji_changed do |data|

        # An enterprise org migration has finished on an external workspace.
        # @see https://api.slack.com/events/external_org_migration_finished
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/external_org_migration_finished.json
        # on :external_org_migration_finished do |data|

        # An enterprise org migration has started on an external workspace.
        # @see https://api.slack.com/events/external_org_migration_started
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/external_org_migration_started.json
        # on :external_org_migration_started do |data|

        # A file was changed.
        # @see https://api.slack.com/events/file_change
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/file_change.json
        # on :file_change do |data|

        # A comment was added to a file.
        # @see https://api.slack.com/events/file_comment
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/file_comment.json
        # on :file_comment do |data|

        # A file comment was added.
        # @see https://api.slack.com/events/file_comment_added
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/file_comment_added.json
        # on :file_comment_added do |data|

        # A file comment was deleted.
        # @see https://api.slack.com/events/file_comment_deleted
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/file_comment_deleted.json
        # on :file_comment_deleted do |data|

        # A file comment was edited.
        # @see https://api.slack.com/events/file_comment_edited
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/file_comment_edited.json
        # on :file_comment_edited do |data|

        # A file was created.
        # @see https://api.slack.com/events/file_created
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/file_created.json
        # on :file_created do |data|

        # A file was deleted.
        # @see https://api.slack.com/events/file_deleted
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/file_deleted.json
        # on :file_deleted do |data|

        # A file was mentioned in a channel.
        # @see https://api.slack.com/events/file_mention
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/file_mention.json
        # on :file_mention do |data|

        # A file was made public.
        # @see https://api.slack.com/events/file_public
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/file_public.json
        # on :file_public do |data|

        # A file was shared into a channel.
        # @see https://api.slack.com/events/file_share
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/file_share.json
        # on :file_share do |data|

        # A file was shared.
        # @see https://api.slack.com/events/file_shared
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/file_shared.json
        # on :file_shared do |data|

        # A file was unshared.
        # @see https://api.slack.com/events/file_unshared
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/file_unshared.json
        # on :file_unshared do |data|

        # Your app function is executed as a step in a workflow.
        # @see https://api.slack.com/events/function_executed
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/function_executed.json
        # on :function_executed do |data|

        # The server intends to close the connection soon.
        # @see https://api.slack.com/events/goodbye
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/goodbye.json
        # on :goodbye do |data|

        # An enterprise org migration has finished on this workspace.
        # @see https://api.slack.com/events/grid_migration_finished
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/grid_migration_finished.json
        # on :grid_migration_finished do |data|

        # An enterprise org migration has started on this workspace.
        # @see https://api.slack.com/events/grid_migration_started
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/grid_migration_started.json
        # on :grid_migration_started do |data|

        # A private channel was archived.
        # @see https://api.slack.com/events/group_archive
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/group_archive.json
        # on :group_archive do |data|

        # You closed a private channel.
        # @see https://api.slack.com/events/group_close
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/group_close.json
        # on :group_close do |data|

        # A private channel was deleted.
        # @see https://api.slack.com/events/group_deleted
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/group_deleted.json
        # on :group_deleted do |data|

        # Bulk updates were made to a private channel's history.
        # @see https://api.slack.com/events/group_history_changed
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/group_history_changed.json
        # on :group_history_changed do |data|

        # A member joined a group.
        # @see https://api.slack.com/events/group_join
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/group_join.json
        # on :group_join do |data|

        # You joined a private channel.
        # @see https://api.slack.com/events/group_joined
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/group_joined.json
        # on :group_joined do |data|

        # A member left a group.
        # @see https://api.slack.com/events/group_leave
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/group_leave.json
        # on :group_leave do |data|

        # You left a private channel.
        # @see https://api.slack.com/events/group_left
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/group_left.json
        # on :group_left do |data|

        # A private channel read marker was updated.
        # @see https://api.slack.com/events/group_marked
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/group_marked.json
        # on :group_marked do |data|

        # A group was renamed.
        # @see https://api.slack.com/events/group_name
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/group_name.json
        # on :group_name do |data|

        # You created a group DM.
        # @see https://api.slack.com/events/group_open
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/group_open.json
        # on :group_open do |data|

        # A group purpose was updated.
        # @see https://api.slack.com/events/group_purpose
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/group_purpose.json
        # on :group_purpose do |data|

        # A private channel was renamed.
        # @see https://api.slack.com/events/group_rename
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/group_rename.json
        # on :group_rename do |data|

        # A group topic was updated.
        # @see https://api.slack.com/events/group_topic
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/group_topic.json
        # on :group_topic do |data|

        # A private channel was unarchived.
        # @see https://api.slack.com/events/group_unarchive
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/group_unarchive.json
        # on :group_unarchive do |data|

        # The client has successfully connected to the server.
        # @see https://api.slack.com/events/hello
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/hello.json
        # on :hello do |data|

        # You closed a DM.
        # @see https://api.slack.com/events/im_close
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/im_close.json
        # on :im_close do |data|

        # A DM was created.
        # @see https://api.slack.com/events/im_created
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/im_created.json
        # on :im_created do |data|

        # Bulk updates were made to a DM's history.
        # @see https://api.slack.com/events/im_history_changed
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/im_history_changed.json
        # on :im_history_changed do |data|

        # A direct message read marker was updated.
        # @see https://api.slack.com/events/im_marked
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/im_marked.json
        # on :im_marked do |data|

        # You opened a DM.
        # @see https://api.slack.com/events/im_open
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/im_open.json
        # on :im_open do |data|

        # User requested an invite.
        # @see https://api.slack.com/events/invite_requested
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/invite_requested.json
        # on :invite_requested do |data|

        # A message was posted containing one or more links relevant to your application.
        # @see https://api.slack.com/events/link_shared
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/link_shared.json
        # on :link_shared do |data|

        # You manually updated your presence.
        # @see https://api.slack.com/events/manual_presence_change
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/manual_presence_change.json
        # on :manual_presence_change do |data|

        # A /me message was sent.
        # @see https://api.slack.com/events/me_message
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/me_message.json
        # on :me_message do |data|

        # A user joined a public channel, private channel or MPDM.
        # @see https://api.slack.com/events/member_joined_channel
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/member_joined_channel.json
        # on :member_joined_channel do |data|

        # A user left a public or private channel.
        # @see https://api.slack.com/events/member_left_channel
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/member_left_channel.json
        # on :member_left_channel do |data|

        # A user sent a message to your Slack app.
        # @see https://api.slack.com/events/message.app_home
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/message.app_home.json
        # on :message.app_home do |data|

        # A message was posted to a channel.
        # @see https://api.slack.com/events/message.channels
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/message.channels.json
        # on :message.channels do |data|

        # A message was posted to a private channel.
        # @see https://api.slack.com/events/message.groups
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/message.groups.json
        # on :message.groups do |data|

        # A message was posted in a direct message channel.
        # @see https://api.slack.com/events/message.im
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/message.im.json
        # on :message.im do |data|

        # A message was posted in a multiparty direct message channel.
        # @see https://api.slack.com/events/message.mpim
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/message.mpim.json
        # on :message.mpim do |data|

        # A message was changed.
        # @see https://api.slack.com/events/message_changed
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/message_changed.json
        # on :message_changed do |data|

        # A message was deleted.
        # @see https://api.slack.com/events/message_deleted
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/message_deleted.json
        # on :message_deleted do |data|

        # Message metadata was deleted.
        # @see https://api.slack.com/events/message_metadata_deleted
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/message_metadata_deleted.json
        # on :message_metadata_deleted do |data|

        # Message metadata was posted.
        # @see https://api.slack.com/events/message_metadata_posted
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/message_metadata_posted.json
        # on :message_metadata_posted do |data|

        # Message metadata was updated.
        # @see https://api.slack.com/events/message_metadata_updated
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/message_metadata_updated.json
        # on :message_metadata_updated do |data|

        # A message thread received a reply.
        # @see https://api.slack.com/events/message_replied
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/message_replied.json
        # on :message_replied do |data|

        # A pin was added to a channel.
        # @see https://api.slack.com/events/pin_added
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/pin_added.json
        # on :pin_added do |data|

        # A pin was removed from a channel.
        # @see https://api.slack.com/events/pin_removed
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/pin_removed.json
        # on :pin_removed do |data|

        # An item was pinned in a channel.
        # @see https://api.slack.com/events/pinned_item
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/pinned_item.json
        # on :pinned_item do |data|

        # You have updated your preferences.
        # @see https://api.slack.com/events/pref_change
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/pref_change.json
        on :pref_change do |data|
          self.self.prefs ||= {}
          self.self.prefs[data.name] = data.value
        end

        # A member's presence changed.
        # @see https://api.slack.com/events/presence_change
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/presence_change.json
        # on :presence_change do |data|

        # Determine the current presence status for a list of users.
        # @see https://api.slack.com/events/presence_query
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/presence_query.json
        # on :presence_query do |data|

        # Subscribe to presence events for the specified users.
        # @see https://api.slack.com/events/presence_sub
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/presence_sub.json
        # on :presence_sub do |data|

        # A member has added an emoji reaction to an item.
        # @see https://api.slack.com/events/reaction_added
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/reaction_added.json
        # on :reaction_added do |data|

        # A member removed an emoji reaction.
        # @see https://api.slack.com/events/reaction_removed
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/reaction_removed.json
        # on :reaction_removed do |data|

        # Experimental.
        # @see https://api.slack.com/events/reconnect_url
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/reconnect_url.json
        # on :reconnect_url do |data|

        # A reminder was added to the channel.
        # @see https://api.slack.com/events/reminder_add
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/reminder_add.json
        # on :reminder_add do |data|

        # (No longer served) A message thread's reply was broadcast to a channel.
        # @see https://api.slack.com/events/reply_broadcast
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/reply_broadcast.json
        # on :reply_broadcast do |data|

        # A shared channel invited was accepted.
        # @see https://api.slack.com/events/shared_channel_invite_accepted
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/shared_channel_invite_accepted.json
        # on :shared_channel_invite_accepted do |data|

        # A shared channel invited was approved.
        # @see https://api.slack.com/events/shared_channel_invite_approved
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/shared_channel_invite_approved.json
        # on :shared_channel_invite_approved do |data|

        # A shared channel invited was declined.
        # @see https://api.slack.com/events/shared_channel_invite_declined
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/shared_channel_invite_declined.json
        # on :shared_channel_invite_declined do |data|

        # A shared channel invited was sent to a Slack user.
        # @see https://api.slack.com/events/shared_channel_invite_received
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/shared_channel_invite_received.json
        # on :shared_channel_invite_received do |data|

        # A shared channel invited was requested.
        # @see https://api.slack.com/events/shared_channel_invite_requested
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/shared_channel_invite_requested.json
        # on :shared_channel_invite_requested do |data|

        # A member has saved an item for later or starred an item.
        # @see https://api.slack.com/events/star_added
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/star_added.json
        # on :star_added do |data|

        # A member has removed an item saved for later or starred an item.
        # @see https://api.slack.com/events/star_removed
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/star_removed.json
        # on :star_removed do |data|

        # A User Group has been added to the workspace.
        # @see https://api.slack.com/events/subteam_created
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/subteam_created.json
        # on :subteam_created do |data|

        # The membership of an existing User Group has changed.
        # @see https://api.slack.com/events/subteam_members_changed
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/subteam_members_changed.json
        # on :subteam_members_changed do |data|

        # You have been added to a User Group.
        # @see https://api.slack.com/events/subteam_self_added
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/subteam_self_added.json
        # on :subteam_self_added do |data|

        # You have been removed from a User Group.
        # @see https://api.slack.com/events/subteam_self_removed
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/subteam_self_removed.json
        # on :subteam_self_removed do |data|

        # An existing User Group has been updated or its members changed.
        # @see https://api.slack.com/events/subteam_updated
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/subteam_updated.json
        # on :subteam_updated do |data|

        # Access to a set of teams was granted to your org app.
        # @see https://api.slack.com/events/team_access_granted
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/team_access_granted.json
        # on :team_access_granted do |data|

        # Access to a set of teams was revoked from your org app.
        # @see https://api.slack.com/events/team_access_revoked
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/team_access_revoked.json
        # on :team_access_revoked do |data|

        # The workspace domain has changed.
        # @see https://api.slack.com/events/team_domain_change
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/team_domain_change.json
        on :team_domain_change do |data|
          team.url = data.url
          team.domain = data.domain
        end

        # A new member has joined.
        # @see https://api.slack.com/events/team_join
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/team_join.json
        # on :team_join do |data|

        # The workspace is being migrated between servers.
        # @see https://api.slack.com/events/team_migration_started
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/team_migration_started.json
        # on :team_migration_started do |data|

        # The account billing plan has changed.
        # @see https://api.slack.com/events/team_plan_change
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/team_plan_change.json
        on :team_plan_change do |data|
          team.plan = data.plan
        end

        # A preference has been updated.
        # @see https://api.slack.com/events/team_pref_change
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/team_pref_change.json
        on :team_pref_change do |data|
          team.prefs ||= {}
          team.prefs[data.name] = data.value
        end

        # The workspace profile fields have been updated.
        # @see https://api.slack.com/events/team_profile_change
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/team_profile_change.json
        # on :team_profile_change do |data|

        # The workspace profile fields have been deleted.
        # @see https://api.slack.com/events/team_profile_delete
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/team_profile_delete.json
        # on :team_profile_delete do |data|

        # The workspace profile fields have been reordered.
        # @see https://api.slack.com/events/team_profile_reorder
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/team_profile_reorder.json
        # on :team_profile_reorder do |data|

        # The workspace name has changed.
        # @see https://api.slack.com/events/team_rename
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/team_rename.json
        on :team_rename do |data|
          team.name = data.name
        end

        # A message thread's reply was broadcast to a channel.
        # @see https://api.slack.com/events/thread_broadcast
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/thread_broadcast.json
        # on :thread_broadcast do |data|

        # API tokens for your app were revoked.
        # @see https://api.slack.com/events/tokens_revoked
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/tokens_revoked.json
        # on :tokens_revoked do |data|

        # An item was unpinned from a channel.
        # @see https://api.slack.com/events/unpinned_item
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/unpinned_item.json
        # on :unpinned_item do |data|

        # Verifies ownership of an Events API Request URL.
        # @see https://api.slack.com/events/url_verification
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/url_verification.json
        # on :url_verification do |data|

        # A member's data has changed.
        # @see https://api.slack.com/events/user_change
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/user_change.json
        # on :user_change do |data|

        # A user's huddle status has changed.
        # @see https://api.slack.com/events/user_huddle_changed
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/user_huddle_changed.json
        # on :user_huddle_changed do |data|

        # A channel member is typing a message.
        # @see https://api.slack.com/events/user_typing
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/user_typing.json
        # on :user_typing do |data|

        # A workflow that contains a step supported by your app was deleted.
        # @see https://api.slack.com/events/workflow_deleted
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/workflow_deleted.json
        # on :workflow_deleted do |data|

        # A workflow that contains a step supported by your app was published.
        # @see https://api.slack.com/events/workflow_published
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/workflow_published.json
        # on :workflow_published do |data|

        # A workflow step supported by your app was removed from a workflow.
        # @see https://api.slack.com/events/workflow_step_deleted
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/workflow_step_deleted.json
        # on :workflow_step_deleted do |data|

        # A workflow step supported by your app should execute.
        # @see https://api.slack.com/events/workflow_step_execute
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/workflow_step_execute.json
        # on :workflow_step_execute do |data|

        # A workflow that contains a step supported by your app was unpublished.
        # @see https://api.slack.com/events/workflow_unpublished
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/workflow_unpublished.json
        # on :workflow_unpublished do |data|

        # A message was posted in a multiparty direct message channel.
        # @see https://api.slack.com/events/message.mpim
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/message.mpim.json
        # on :message.mpim do |data|

        # A message was posted in a direct message channel.
        # @see https://api.slack.com/events/message.im
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/message.im.json
        # on :message.im do |data|

        # A message was posted to a private channel.
        # @see https://api.slack.com/events/message.groups
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/message.groups.json
        # on :message.groups do |data|

        # A message was posted to a channel.
        # @see https://api.slack.com/events/message.channels
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/message.channels.json
        # on :message.channels do |data|
      end
    end
  end
end
