# frozen_string_literal: true
# This file was auto-generated by lib/tasks/web.rake

module Slack
  module Web
    module Api
      module Endpoints
        module AdminConversations
          #
          # Archive a public or private channel.
          #
          # @option options [Object] :channel_id
          #   The channel to archive.
          # @see https://api.slack.com/methods/admin.conversations.archive
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/admin.conversations/admin.conversations.archive.json
          def admin_conversations_archive(options = {})
            raise ArgumentError, 'Required arguments :channel_id missing' if options[:channel_id].nil?
            post('admin.conversations.archive', options)
          end

          #
          # Archive public or private channels in bulk.
          #
          # @option options [array] :channel_ids
          #   An array of channel IDs to archive. No more than 100 items are allowed.
          # @see https://api.slack.com/methods/admin.conversations.bulkArchive
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/admin.conversations/admin.conversations.bulkArchive.json
          def admin_conversations_bulkArchive(options = {})
            raise ArgumentError, 'Required arguments :channel_ids missing' if options[:channel_ids].nil?
            post('admin.conversations.bulkArchive', options)
          end

          #
          # Delete public or private channels in bulk
          #
          # @option options [array] :channel_ids
          #   An array of channel IDs.
          # @see https://api.slack.com/methods/admin.conversations.bulkDelete
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/admin.conversations/admin.conversations.bulkDelete.json
          def admin_conversations_bulkDelete(options = {})
            raise ArgumentError, 'Required arguments :channel_ids missing' if options[:channel_ids].nil?
            post('admin.conversations.bulkDelete', options)
          end

          #
          # Move public or private channels in bulk.
          #
          # @option options [array] :channel_ids
          #   An array of channel IDs.
          # @option options [string] :target_team_id
          #   Target team ID.
          # @see https://api.slack.com/methods/admin.conversations.bulkMove
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/admin.conversations/admin.conversations.bulkMove.json
          def admin_conversations_bulkMove(options = {})
            raise ArgumentError, 'Required arguments :channel_ids missing' if options[:channel_ids].nil?
            raise ArgumentError, 'Required arguments :target_team_id missing' if options[:target_team_id].nil?
            post('admin.conversations.bulkMove', options)
          end

          #
          # Convert a public channel to a private channel.
          #
          # @option options [Object] :channel_id
          #   The channel to convert to private.
          # @option options [string] :name
          #   Name of private channel to create. Only respected when converting an MPIM.
          # @see https://api.slack.com/methods/admin.conversations.convertToPrivate
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/admin.conversations/admin.conversations.convertToPrivate.json
          def admin_conversations_convertToPrivate(options = {})
            raise ArgumentError, 'Required arguments :channel_id missing' if options[:channel_id].nil?
            post('admin.conversations.convertToPrivate', options)
          end

          #
          # Convert a private channel to a public channel.
          #
          # @option options [Object] :channel_id
          #   The channel to convert to public.
          # @see https://api.slack.com/methods/admin.conversations.convertToPublic
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/admin.conversations/admin.conversations.convertToPublic.json
          def admin_conversations_convertToPublic(options = {})
            raise ArgumentError, 'Required arguments :channel_id missing' if options[:channel_id].nil?
            post('admin.conversations.convertToPublic', options)
          end

          #
          # Create a public or private channel-based conversation.
          #
          # @option options [boolean] :is_private
          #   When true, creates a private channel instead of a public channel.
          # @option options [string] :name
          #   Name of the public or private channel to create.
          # @option options [string] :description
          #   Description of the public or private channel to create.
          # @option options [boolean] :org_wide
          #   When true, the channel will be available org-wide. Note: if the channel is not org_wide=true, you must specify a team_id for this channel.
          # @option options [Object] :team_id
          #   The workspace to create the channel in. Note: this argument is required unless you set org_wide=true.
          # @see https://api.slack.com/methods/admin.conversations.create
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/admin.conversations/admin.conversations.create.json
          def admin_conversations_create(options = {})
            raise ArgumentError, 'Required arguments :is_private missing' if options[:is_private].nil?
            raise ArgumentError, 'Required arguments :name missing' if options[:name].nil?
            post('admin.conversations.create', options)
          end

          #
          # Delete a public or private channel.
          #
          # @option options [Object] :channel_id
          #   The channel to delete.
          # @see https://api.slack.com/methods/admin.conversations.delete
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/admin.conversations/admin.conversations.delete.json
          def admin_conversations_delete(options = {})
            raise ArgumentError, 'Required arguments :channel_id missing' if options[:channel_id].nil?
            post('admin.conversations.delete', options)
          end

          #
          # Disconnect a connected channel from one or more workspaces.
          #
          # @option options [Object] :channel_id
          #   The channel to be disconnected from some workspaces.
          # @option options [array] :leaving_team_ids
          #   team IDs getting removed from the channel, optional if there are only two teams in the channel.
          # @see https://api.slack.com/methods/admin.conversations.disconnectShared
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/admin.conversations/admin.conversations.disconnectShared.json
          def admin_conversations_disconnectShared(options = {})
            raise ArgumentError, 'Required arguments :channel_id missing' if options[:channel_id].nil?
            post('admin.conversations.disconnectShared', options)
          end

          #
          # Get conversation preferences for a public or private channel.
          #
          # @option options [Object] :channel_id
          #   The channel to get preferences for.
          # @see https://api.slack.com/methods/admin.conversations.getConversationPrefs
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/admin.conversations/admin.conversations.getConversationPrefs.json
          def admin_conversations_getConversationPrefs(options = {})
            raise ArgumentError, 'Required arguments :channel_id missing' if options[:channel_id].nil?
            post('admin.conversations.getConversationPrefs', options)
          end

          #
          # This API endpoint can be used by any admin to get a conversation's retention policy.
          #
          # @option options [string] :channel_id
          #   The conversation to get the retention policy for.
          # @see https://api.slack.com/methods/admin.conversations.getCustomRetention
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/admin.conversations/admin.conversations.getCustomRetention.json
          def admin_conversations_getCustomRetention(options = {})
            raise ArgumentError, 'Required arguments :channel_id missing' if options[:channel_id].nil?
            post('admin.conversations.getCustomRetention', options)
          end

          #
          # Get all the workspaces a given public or private channel is connected to within this Enterprise org.
          #
          # @option options [Object] :channel_id
          #   The channel to determine connected workspaces within the organization for.
          # @option options [string] :cursor
          #   Set cursor to next_cursor returned by the previous call to list items in the next page.
          # @option options [integer] :limit
          #   The maximum number of items to return. Must be between 1 - 1000 both inclusive.
          # @see https://api.slack.com/methods/admin.conversations.getTeams
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/admin.conversations/admin.conversations.getTeams.json
          def admin_conversations_getTeams(options = {})
            raise ArgumentError, 'Required arguments :channel_id missing' if options[:channel_id].nil?
            if block_given?
              Pagination::Cursor.new(self, :admin_conversations_getTeams, options).each do |page|
                yield page
              end
            else
              post('admin.conversations.getTeams', options)
            end
          end

          #
          # Invite a user to a public or private channel.
          #
          # @option options [Object] :channel_id
          #   The channel that the users will be invited to.
          # @option options [array] :user_ids
          #   The users to invite.
          # @see https://api.slack.com/methods/admin.conversations.invite
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/admin.conversations/admin.conversations.invite.json
          def admin_conversations_invite(options = {})
            raise ArgumentError, 'Required arguments :channel_id missing' if options[:channel_id].nil?
            raise ArgumentError, 'Required arguments :user_ids missing' if options[:user_ids].nil?
            post('admin.conversations.invite', options)
          end

          #
          # Link a Salesforce record to a channel
          #
          # @option options [channel] :channel
          #   Channel ID for Slack channel that will be linked to a Salesforce record.
          # @option options [string] :record_id
          #   Salesforce record ID (15 or 18 digit accepted). See here for how to look up record ID.
          # @option options [string] :salesforce_org_id
          #   Salesforce org ID (15 or 18 digit accepted). See here for how to look up Salesforce org ID.
          # @see https://api.slack.com/methods/admin.conversations.linkObjects
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/admin.conversations/admin.conversations.linkObjects.json
          def admin_conversations_linkObjects(options = {})
            raise ArgumentError, 'Required arguments :channel missing' if options[:channel].nil?
            raise ArgumentError, 'Required arguments :record_id missing' if options[:record_id].nil?
            raise ArgumentError, 'Required arguments :salesforce_org_id missing' if options[:salesforce_org_id].nil?
            options = options.merge(channel: conversations_id(options)['channel']['id']) if options[:channel]
            post('admin.conversations.linkObjects', options)
          end

          #
          # Returns channels on the given team using the filters.
          #
          # @option options [integer] :last_message_activity_before
          #   Filter by public channels where the most recent message was sent before last_message_activity.
          # @option options [array] :team_ids
          #   Array of team IDs to filter by.
          # @option options [string] :cursor
          #   Set cursor to next_cursor returned in the previous call, to fetch the next page.
          # @option options [integer] :limit
          #   Maximum number of results.
          # @option options [integer] :max_member_count
          #   Filter by public channels with member count equal to or less than the specified number.
          # @see https://api.slack.com/methods/admin.conversations.lookup
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/admin.conversations/admin.conversations.lookup.json
          def admin_conversations_lookup(options = {})
            raise ArgumentError, 'Required arguments :last_message_activity_before missing' if options[:last_message_activity_before].nil?
            raise ArgumentError, 'Required arguments :team_ids missing' if options[:team_ids].nil?
            if block_given?
              Pagination::Cursor.new(self, :admin_conversations_lookup, options).each do |page|
                yield page
              end
            else
              post('admin.conversations.lookup', options)
            end
          end

          #
          # This API endpoint can be used by any admin to remove a conversation's retention policy.
          #
          # @option options [string] :channel_id
          #   The conversation to set the retention policy for.
          # @see https://api.slack.com/methods/admin.conversations.removeCustomRetention
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/admin.conversations/admin.conversations.removeCustomRetention.json
          def admin_conversations_removeCustomRetention(options = {})
            raise ArgumentError, 'Required arguments :channel_id missing' if options[:channel_id].nil?
            post('admin.conversations.removeCustomRetention', options)
          end

          #
          # Rename a public or private channel.
          #
          # @option options [Object] :channel_id
          #   The channel to rename.
          # @option options [string] :name
          #   .
          # @see https://api.slack.com/methods/admin.conversations.rename
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/admin.conversations/admin.conversations.rename.json
          def admin_conversations_rename(options = {})
            raise ArgumentError, 'Required arguments :channel_id missing' if options[:channel_id].nil?
            raise ArgumentError, 'Required arguments :name missing' if options[:name].nil?
            post('admin.conversations.rename', options)
          end

          #
          # Search for public or private channels in an Enterprise organization.
          #
          # @option options [array] :connected_team_ids
          #   Array of encoded team IDs, signifying the external orgs to search through.
          # @option options [string] :cursor
          #   Set cursor to next_cursor returned by the previous call to list items in the next page.
          # @option options [integer] :limit
          #   Maximum number of items to be returned. Must be between 1 - 20 both inclusive. Default is 10.
          # @option options [string] :query
          #   Name of the the channel to query by.
          # @option options [array] :search_channel_types
          #   The type of channel to include or exclude in the search. For example private will search private channels, while private_exclude will exclude them. For a full list of types, check the Types section.
          # @option options [string] :sort
          #   Possible values are relevant (search ranking based on what we think is closest), name (alphabetical), member_count (number of users in the channel), and created (date channel was created). You can optionally pair this with the sort_dir arg to change how it is sorted.
          # @option options [string] :sort_dir
          #   Sort direction. Possible values are asc for ascending order like (1, 2, 3) or (a, b, c), and desc for descending order like (3, 2, 1) or (c, b, a).
          # @option options [array] :team_ids
          #   Comma separated string of team IDs, signifying the internal workspaces to search through.
          # @option options [boolean] :total_count_only
          #   Only return the total_count of channels. Omits channel data and allows access for admins without channel manager permissions.
          # @see https://api.slack.com/methods/admin.conversations.search
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/admin.conversations/admin.conversations.search.json
          def admin_conversations_search(options = {})
            if block_given?
              Pagination::Cursor.new(self, :admin_conversations_search, options).each do |page|
                yield page
              end
            else
              post('admin.conversations.search', options)
            end
          end

          #
          # Set the posting permissions for a public or private channel.
          #
          # @option options [string] :channel_id
          #   The channel to set the prefs for.
          # @option options [string] :prefs
          #   The prefs for this channel in a stringified JSON format.
          # @see https://api.slack.com/methods/admin.conversations.setConversationPrefs
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/admin.conversations/admin.conversations.setConversationPrefs.json
          def admin_conversations_setConversationPrefs(options = {})
            raise ArgumentError, 'Required arguments :channel_id missing' if options[:channel_id].nil?
            raise ArgumentError, 'Required arguments :prefs missing' if options[:prefs].nil?
            options = encode_options_as_json(options, %i[prefs])
            post('admin.conversations.setConversationPrefs', options)
          end

          #
          # This API endpoint can be used by any admin to set a conversation's retention policy.
          #
          # @option options [string] :channel_id
          #   The conversation to set the retention policy for.
          # @option options [integer] :duration_days
          #   The message retention duration in days to set for this conversation.
          # @see https://api.slack.com/methods/admin.conversations.setCustomRetention
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/admin.conversations/admin.conversations.setCustomRetention.json
          def admin_conversations_setCustomRetention(options = {})
            raise ArgumentError, 'Required arguments :channel_id missing' if options[:channel_id].nil?
            raise ArgumentError, 'Required arguments :duration_days missing' if options[:duration_days].nil?
            post('admin.conversations.setCustomRetention', options)
          end

          #
          # Set the workspaces in an Enterprise grid org that connect to a public or private channel.
          #
          # @option options [string] :channel_id
          #   The encoded channel_id to add or remove to workspaces.
          # @option options [boolean] :org_channel
          #   True if channel has to be converted to an org channel.
          # @option options [array] :target_team_ids
          #   A comma-separated list of workspaces to which the channel should be shared. Not required if the channel is being shared org-wide.
          # @option options [Object] :team_id
          #   The workspace to which the channel belongs. Omit this argument if the channel is a cross-workspace shared channel.
          # @see https://api.slack.com/methods/admin.conversations.setTeams
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/admin.conversations/admin.conversations.setTeams.json
          def admin_conversations_setTeams(options = {})
            raise ArgumentError, 'Required arguments :channel_id missing' if options[:channel_id].nil?
            post('admin.conversations.setTeams', options)
          end

          #
          # Unarchive a public or private channel.
          #
          # @option options [Object] :channel_id
          #   The channel to unarchive.
          # @see https://api.slack.com/methods/admin.conversations.unarchive
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/admin.conversations/admin.conversations.unarchive.json
          def admin_conversations_unarchive(options = {})
            raise ArgumentError, 'Required arguments :channel_id missing' if options[:channel_id].nil?
            post('admin.conversations.unarchive', options)
          end

          #
          # Unlink a Salesforce record from a channel
          #
          # @option options [channel] :channel
          #   Channel ID for Slack channel that will be unlinked from the Salesforce record.
          # @option options [string] :new_name
          #   Channel name you would like to give to the channel that is being unlinked from the Salesforce record.
          # @see https://api.slack.com/methods/admin.conversations.unlinkObjects
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/admin.conversations/admin.conversations.unlinkObjects.json
          def admin_conversations_unlinkObjects(options = {})
            raise ArgumentError, 'Required arguments :channel missing' if options[:channel].nil?
            raise ArgumentError, 'Required arguments :new_name missing' if options[:new_name].nil?
            options = options.merge(channel: conversations_id(options)['channel']['id']) if options[:channel]
            post('admin.conversations.unlinkObjects', options)
          end
        end
      end
    end
  end
end
