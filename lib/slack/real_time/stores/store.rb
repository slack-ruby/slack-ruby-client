# frozen_string_literal: true
module Slack
  module RealTime
    module Stores
      # Stores everything.
      class Store < Base
        def self
          users[@self_id]
        end

        def team
          teams[@team_id]
        end

        def initialize(attrs)
          if attrs.team
            @team_id = attrs.team.id
            @teams = { @team_id => Slack::RealTime::Models::Team.new(attrs.team) }
          else
            @teams = {}
          end

          if attrs.self
            @self_id = attrs.self.id
            @users = { @self_id => Slack::RealTime::Models::User.new(attrs.self) }
          else
            @users = {}
          end

          attrs.users&.each do |data|
            user = Models::User.new(data)
            @users[data.id] = @users.key?(data.id) ? @users[data.id].merge(user) : user
          end

          @channels = {}
          attrs.channels&.each do |data|
            @channels[data.id] = Models::Channel.new(data)
          end

          @bots = {}
          attrs.bots&.each do |data|
            @bots[data.id] = Models::Bot.new(data)
          end

          @groups = {}
          attrs.groups&.each do |data|
            @groups[data.id] = Models::Group.new(data)
          end

          @ims = {}
          attrs.ims&.each do |data|
            @ims[data.id] = Models::Im.new(data)
          end
        end

        ### RealTime Events

        # An enterprise grid migration has started on an external workspace..
        # @see https://api.slack.com/events/external_org_migration_started
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/external_org_migration_started.json
        # on :external_org_migration_started do |data|

        # An enterprise grid migration has finished on an external workspace..
        # @see https://api.slack.com/events/external_org_migration_finished
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/external_org_migration_finished.json
        # on :external_org_migration_finished do |data|

        # A private channel was deleted.
        # @see https://api.slack.com/events/group_deleted
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/group_deleted.json
        # on :group_deleted do |data|

        # Determine the current presence status for a list of users.
        # @see https://api.slack.com/events/presence_query
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/presence_query.json
        # on :presence_query do |data|

        # The membership of an existing User Group has changed.
        # @see https://api.slack.com/events/subteam_members_changed
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/subteam_members_changed.json
        # on :subteam_members_changed do |data|

        # Subscribe to presence events for the specified users.
        # @see https://api.slack.com/events/presence_sub
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/presence_sub.json
        # on :presence_sub do |data|

        # A user left a public or private channel.
        # @see https://api.slack.com/events/member_left_channel
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/member_left_channel.json
        # on :member_left_channel do |data|

        # A user joined a public or private channel.
        # @see https://api.slack.com/events/member_joined_channel
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/member_joined_channel.json
        # on :member_joined_channel do |data|

        # The server intends to close the connection soon..
        # @see https://api.slack.com/events/goodbye
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/goodbye.json
        # on :goodbye do |data|

        # Verifies ownership of an Events API Request URL.
        # @see https://api.slack.com/events/url_verification
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/url_verification.json
        # on :url_verification do |data|

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

        # A direct message read marker was updated.
        # @see https://api.slack.com/events/im_marked
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/im_marked.json
        # on :im_marked do |data|

        # Bulk updates were made to a DM channel's history.
        # @see https://api.slack.com/events/im_history_changed
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/im_history_changed.json
        # on :im_history_changed do |data|

        # The list of accounts a user is signed into has changed.
        # @see https://api.slack.com/events/accounts_changed
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/accounts_changed.json
        # on :accounts_changed do |data|

        # An integration bot was added.
        # @see https://api.slack.com/events/bot_added
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/bot_added.json
        on :bot_added do |data|
          bots[data.bot.id] = Models::Bot.new(data.bot)
        end

        # An integration bot was changed.
        # @see https://api.slack.com/events/bot_changed
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/bot_changed.json
        on :bot_changed do |data|
          bot = bots[data.bot.id]
          bot&.merge!(data.bot)
        end

        # A team channel was archived.
        # @see https://api.slack.com/events/channel_archive
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/channel_archive.json
        on :channel_archive do |data|
          channel = channels[data.channel]
          channel.is_archived = true if channel
        end

        # A team channel was created.
        # @see https://api.slack.com/events/channel_created
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/channel_created.json
        on :channel_created do |data|
          channel = Models::Channel.new(data.channel)
          channels[channel.id] = channel
        end

        # A team channel was deleted.
        # @see https://api.slack.com/events/channel_deleted
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/channel_deleted.json
        on :channel_deleted do |data|
          channels.delete(data.channel)
        end

        # Bulk updates were made to a channel's history.
        # @see https://api.slack.com/events/channel_history_changed
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/channel_history_changed.json
        # on :channel_history_changed do |data|

        # You joined a channel.
        # @see https://api.slack.com/events/channel_joined
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/channel_joined.json
        on :channel_joined do |data|
          channel_id = data.channel.id
          channel = channels[channel_id]
          if channel
            channel.merge!(data.channel)
          else
            channels[channel_id] = Models::Channel.new(data.channel)
          end
        end

        # You left a channel.
        # @see https://api.slack.com/events/channel_left
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/channel_left.json
        on :channel_left do |data|
          channel = channels[data.channel]
          channel.members.delete(self.self.id) if channel.key? :members
        end

        # Your channel read marker was updated.
        # @see https://api.slack.com/events/channel_marked
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/channel_marked.json
        # on :channel_marked do |data|

        # A team channel was renamed.
        # @see https://api.slack.com/events/channel_rename
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/channel_rename.json
        on :channel_rename do |data|
          channel = channels[data.channel.id]
          channel.name = data.channel.name if channel
        end

        # A team channel was unarchived.
        # @see https://api.slack.com/events/channel_unarchive
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/channel_unarchive.json
        on :channel_unarchive do |data|
          channel = channels[data.channel]
          channel.is_archived = false if channel
        end

        # A team slash command has been added or changed.
        # @see https://api.slack.com/events/commands_changed
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/commands_changed.json
        # on :commands_changed do |data|

        # Do not Disturb settings changed for the current user.
        # @see https://api.slack.com/events/dnd_updated
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/dnd_updated.json
        # on :dnd_updated do |data|

        # Do not Disturb settings changed for a team member.
        # @see https://api.slack.com/events/dnd_updated_user
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/dnd_updated_user.json
        # on :dnd_updated_user do |data|

        # The team email domain has changed.
        # @see https://api.slack.com/events/email_domain_changed
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/email_domain_changed.json
        on :email_domain_changed do |data|
          team.email_domain = data.email_domain
        end

        # A team custom emoji has been added or changed.
        # @see https://api.slack.com/events/emoji_changed
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/emoji_changed.json
        # on :emoji_changed do |data|

        # A file was changed.
        # @see https://api.slack.com/events/file_change
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/file_change.json
        # on :file_change do |data|

        # A file comment was added.
        # @see https://api.slack.com/events/file_comment_added
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/file_comment_added.json
        # on :file_comment_added do |data| do

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

        # A file was made private.
        # @see https://api.slack.com/events/file_private
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/file_private.json
        # on :file_private do |data|

        # A file was made public.
        # @see https://api.slack.com/events/file_public
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/file_public.json
        # on :file_public do |data|

        # A file was shared.
        # @see https://api.slack.com/events/file_shared
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/file_shared.json
        # on :file_shared do |data|

        # A file was unshared.
        # @see https://api.slack.com/events/file_unshared
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/file_unshared.json
        # on :file_unshared do |data|

        # A private group was archived.
        # @see https://api.slack.com/events/group_archive
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/group_archive.json
        on :group_archive do |data|
          channel = groups[data.channel]
          channel.is_archived = true if channel
        end

        # You closed a group channel.
        # @see https://api.slack.com/events/group_close
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/group_close.json
        on :group_close do |data|
          groups[data.channel].is_open = false
        end

        # Bulk updates were made to a group's history.
        # @see https://api.slack.com/events/group_history_changed
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/group_history_changed.json
        # on :group_history_changed do |data|

        # You joined a private group.
        # @see https://api.slack.com/events/group_joined
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/group_joined.json
        on :group_joined do |data|
          groups[data.channel.id] = Models::Channel.new(data.channel)
        end

        # You left a private group.
        # @see https://api.slack.com/events/group_left
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/group_left.json
        on :group_left do |data|
          channel = groups[data.channel]
          channel.members.delete(self.self.id) if channel&.key?(:members)
        end

        # A private group read marker was updated.
        # @see https://api.slack.com/events/group_marked
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/group_marked.json
        # on :group_marked do |data|

        # You opened a group channel.
        # @see https://api.slack.com/events/group_open
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/group_open.json
        on :group_open do |data|
          groups[data.channel].is_open = true
        end

        # A private group was renamed.
        # @see https://api.slack.com/events/group_rename
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/group_rename.json
        on :group_rename do |data|
          channel = groups[data.channel.id]
          channel.name = data.channel.name if channel
        end

        # A private group was unarchived.
        # @see https://api.slack.com/events/group_unarchive
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/group_unarchive.json
        on :group_unarchive do |data|
          channel = groups[data.channel]
          channel.is_archived = false if channel
        end

        # You closed a direct message channel.
        # @see https://api.slack.com/events/im_close
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/im_close.json
        on :im_close do |data|
          return unless ims&.key?(data.channel)

          ims[data.channel].is_open = false
        end

        # A direct message channel was created.
        # @see https://api.slack.com/events/im_created
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/im_created.json
        on :im_created do |data|
          ims[data.channel.id] = Models::Im.new(data.channel)
        end

        # Bulk updates were made to a DM channel's history.
        # @see https://api.slack.com/events/im_history_changed
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/im_history_changed.json
        # on :im_history_changed do |data|

        # A direct message read marker was updated.
        # @see https://api.slack.com/events/im_marked
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/im_marked.json
        # on :im_marked do |data|

        # You opened a direct message channel.
        # @see https://api.slack.com/events/im_open
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/im_open.json
        on :im_open do |data|
          return unless ims&.key?(data.channel)

          ims[data.channel].is_open = true
        end

        # You manually updated your presence.
        # @see https://api.slack.com/events/manual_presence_change
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/manual_presence_change.json
        on :manual_presence_change do |data|
          self.self.presence = data.presence
        end

        # A pin was added to a channel.
        # @see https://api.slack.com/events/pin_added
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/pin_added.json
        # on :pin_added do |data|

        # A pin was removed from a channel.
        # @see https://api.slack.com/events/pin_removed
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/pin_removed.json
        # on :pin_removed do |data|

        # You have updated your preferences.
        # @see https://api.slack.com/events/pref_change
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/pref_change.json
        on :pref_change do |data|
          self.self.prefs ||= {}
          self.self.prefs[data.name] = data.value
        end

        # A team member's presence changed.
        # @see https://api.slack.com/events/presence_change
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/presence_change.json
        on :presence_change do |data|
          user = users[data.user]
          user.presence = data.presence if user
        end

        # A team member has added an emoji reaction to an item.
        # @see https://api.slack.com/events/reaction_added
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/reaction_added.json
        # on :reaction_added do |data|

        # A team member removed an emoji reaction.
        # @see https://api.slack.com/events/reaction_removed
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/reaction_removed.json
        # on :reaction_removed do |data|

        # Experimental.
        # @see https://api.slack.com/events/reconnect_url
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/reconnect_url.json
        # on :reconnect_url do |data|

        # A team member has starred an item.
        # @see https://api.slack.com/events/star_added
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/star_added.json
        # on :star_added do |data|

        # A team member removed a star.
        # @see https://api.slack.com/events/star_removed
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/star_removed.json
        # on :star_removed do |data|

        # A user group has been added to the team.
        # @see https://api.slack.com/events/subteam_created
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/subteam_created.json
        # on :subteam_created do |data|

        # You have been added to a user group.
        # @see https://api.slack.com/events/subteam_self_added
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/subteam_self_added.json
        # on :subteam_self_added do |data|

        # You have been removed from a user group.
        # @see https://api.slack.com/events/subteam_self_removed
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/subteam_self_removed.json
        # on :subteam_self_removed do |data|

        # An existing user group has been updated or its members changed.
        # @see https://api.slack.com/events/subteam_updated
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/subteam_updated.json
        # on :subteam_updated do |data|

        # The team domain has changed.
        # @see https://api.slack.com/events/team_domain_change
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/team_domain_change.json
        on :team_domain_change do |data|
          team.url = data.url
          team.domain = data.domain
        end

        # A new team member has joined.
        # @see https://api.slack.com/events/team_join
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/team_join.json
        on :team_join do |data|
          users[data.user.id] = Models::User.new(data.user)
        end

        # The team is being migrated between servers.
        # @see https://api.slack.com/events/team_migration_started
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/team_migration_started.json
        # on :team_migration_started do |data|

        # The team billing plan has changed.
        # @see https://api.slack.com/events/team_plan_change
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/team_plan_change.json
        on :team_plan_change do |data|
          team.plan = data.plan
        end

        # A team preference has been updated.
        # @see https://api.slack.com/events/team_pref_change
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/team_pref_change.json
        on :team_pref_change do |data|
          team.prefs ||= {}
          team.prefs[data.name] = data.value
        end

        # Team profile fields have been updated.
        # @see https://api.slack.com/events/team_profile_change
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/team_profile_change.json
        # on :team_profile_change do |data|

        # Team profile fields have been deleted.
        # @see https://api.slack.com/events/team_profile_delete
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/team_profile_delete.json
        # on :team_profile_delete do |data|

        # Team profile fields have been reordered.
        # @see https://api.slack.com/events/team_profile_reorder
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/team_profile_reorder.json
        # on :team_profile_reorder do |data|

        # The team name has changed.
        # @see https://api.slack.com/events/team_rename
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/team_rename.json
        on :team_rename do |data|
          team.name = data.name
        end

        # A team member's data has changed.
        # @see https://api.slack.com/events/user_change
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/user_change.json
        on :user_change do |data|
          users[data.user.id] = Models::User.new(data.user)
        end

        # A channel member is typing a message.
        # @see https://api.slack.com/events/user_typing
        # @see https://github.com/slack-ruby/slack-api-ref/blob/master/events/user_typing.json
        # on :user_typing do |data|
      end
    end
  end
end
