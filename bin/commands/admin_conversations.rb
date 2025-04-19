# frozen_string_literal: true
# This file was auto-generated by lib/tasks/web.rake

module Slack
  module Cli
    class App
      desc 'AdminConversations methods.'
      command 'admin_conversations' do |g|
        g.desc 'Archive a public or private channel.'
        g.long_desc %( Archive a public or private channel. )
        g.command 'archive' do |c|
          c.flag 'channel_id', desc: 'The channel to archive.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.admin_conversations_archive(options))
          end
        end

        g.desc 'Archive public or private channels in bulk.'
        g.long_desc %( Archive public or private channels in bulk. )
        g.command 'bulkArchive' do |c|
          c.flag 'channel_ids', desc: 'An array of channel IDs to archive. No more than 100 items are allowed.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.admin_conversations_bulkArchive(options))
          end
        end

        g.desc 'Delete public or private channels in bulk'
        g.long_desc %( Delete public or private channels in bulk )
        g.command 'bulkDelete' do |c|
          c.flag 'channel_ids', desc: 'An array of channel IDs.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.admin_conversations_bulkDelete(options))
          end
        end

        g.desc 'Move public or private channels in bulk.'
        g.long_desc %( Move public or private channels in bulk. )
        g.command 'bulkMove' do |c|
          c.flag 'channel_ids', desc: 'An array of channel IDs.'
          c.flag 'target_team_id', desc: 'Target team ID.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.admin_conversations_bulkMove(options))
          end
        end

        g.desc 'Convert a public channel to a private channel.'
        g.long_desc %( Convert a public channel to a private channel. )
        g.command 'convertToPrivate' do |c|
          c.flag 'channel_id', desc: 'The channel to convert to private.'
          c.flag 'name', desc: 'Name of private channel to create. Only respected when converting an MPIM.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.admin_conversations_convertToPrivate(options))
          end
        end

        g.desc 'Convert a private channel to a public channel.'
        g.long_desc %( Convert a private channel to a public channel. )
        g.command 'convertToPublic' do |c|
          c.flag 'channel_id', desc: 'The channel to convert to public.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.admin_conversations_convertToPublic(options))
          end
        end

        g.desc 'Create a public or private channel-based conversation.'
        g.long_desc %( Create a public or private channel-based conversation. )
        g.command 'create' do |c|
          c.flag 'is_private', desc: 'When true, creates a private channel instead of a public channel.'
          c.flag 'name', desc: 'Name of the public or private channel to create.'
          c.flag 'description', desc: 'Description of the public or private channel to create.'
          c.flag 'org_wide', desc: 'When true, the channel will be available org-wide. Note: if the channel is not org_wide=true, you must specify a team_id for this channel.'
          c.flag 'team_id', desc: 'The workspace to create the channel in. Note: this argument is required unless you set org_wide=true.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.admin_conversations_create(options))
          end
        end

        g.desc 'Create a Salesforce channel for the corresponding object provided.'
        g.long_desc %( Create a Salesforce channel for the corresponding object provided. )
        g.command 'createForObjects' do |c|
          c.flag 'object_id', desc: 'Object / Record ID (15 or 18 digit accepted). See here for how to look up an ID.'
          c.flag 'salesforce_org_id', desc: 'Salesforce org ID (15 or 18 digit accepted). See here for how to look up Salesforce org ID.'
          c.flag 'invite_object_team', desc: 'Optional flag to add all team members related to the object to the newly created Salesforce channel. When true, adds a maximum of 100 team members to the channel.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.admin_conversations_createForObjects(options))
          end
        end

        g.desc 'Delete a public or private channel.'
        g.long_desc %( Delete a public or private channel. )
        g.command 'delete' do |c|
          c.flag 'channel_id', desc: 'The channel to delete.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.admin_conversations_delete(options))
          end
        end

        g.desc 'Disconnect a connected channel from one or more workspaces.'
        g.long_desc %( Disconnect a connected channel from one or more workspaces. )
        g.command 'disconnectShared' do |c|
          c.flag 'channel_id', desc: 'The channel to be disconnected from some workspaces.'
          c.flag 'leaving_team_ids', desc: 'team IDs getting removed from the channel, optional if there are only two teams in the channel.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.admin_conversations_disconnectShared(options))
          end
        end

        g.desc 'Get conversation preferences for a public or private channel.'
        g.long_desc %( Get conversation preferences for a public or private channel. )
        g.command 'getConversationPrefs' do |c|
          c.flag 'channel_id', desc: 'The channel to get preferences for.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.admin_conversations_getConversationPrefs(options))
          end
        end

        g.desc "This API endpoint can be used by any admin to get a conversation's retention policy."
        g.long_desc %( This API endpoint can be used by any admin to get a conversation's retention policy. )
        g.command 'getCustomRetention' do |c|
          c.flag 'channel_id', desc: 'The conversation to get the retention policy for.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.admin_conversations_getCustomRetention(options))
          end
        end

        g.desc 'Get all the workspaces a given public or private channel is connected to within this Enterprise org.'
        g.long_desc %( Get all the workspaces a given public or private channel is connected to within this Enterprise org. )
        g.command 'getTeams' do |c|
          c.flag 'channel_id', desc: 'The channel to determine connected workspaces within the organization for.'
          c.flag 'cursor', desc: 'Set cursor to next_cursor returned by the previous call to list items in the next page.'
          c.flag 'limit', desc: 'The maximum number of items to return. Must be between 1 - 1000 both inclusive.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.admin_conversations_getTeams(options))
          end
        end

        g.desc 'Invite a user to a public or private channel.'
        g.long_desc %( Invite a user to a public or private channel. )
        g.command 'invite' do |c|
          c.flag 'channel_id', desc: 'The channel that the users will be invited to.'
          c.flag 'user_ids', desc: 'The users to invite.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.admin_conversations_invite(options))
          end
        end

        g.desc 'Link a Salesforce record to a channel'
        g.long_desc %( Link a Salesforce record to a channel )
        g.command 'linkObjects' do |c|
          c.flag 'channel', desc: 'Channel ID for Slack channel that will be linked to a Salesforce record.'
          c.flag 'record_id', desc: 'Salesforce record ID (15 or 18 digit accepted). See here for how to look up record ID.'
          c.flag 'salesforce_org_id', desc: 'Salesforce org ID (15 or 18 digit accepted). See here for how to look up Salesforce org ID.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.admin_conversations_linkObjects(options))
          end
        end

        g.desc 'Returns channels on the given team using the filters.'
        g.long_desc %( Returns channels on the given team using the filters. )
        g.command 'lookup' do |c|
          c.flag 'last_message_activity_before', desc: 'Filter by public channels where the most recent message was sent before last_message_activity.'
          c.flag 'team_ids', desc: 'Array of team IDs to filter by.'
          c.flag 'cursor', desc: 'Set cursor to next_cursor returned in the previous call, to fetch the next page.'
          c.flag 'limit', desc: 'Maximum number of results.'
          c.flag 'max_member_count', desc: 'Filter by public channels with member count equal to or less than the specified number.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.admin_conversations_lookup(options))
          end
        end

        g.desc "This API endpoint can be used by any admin to remove a conversation's retention policy."
        g.long_desc %( This API endpoint can be used by any admin to remove a conversation's retention policy. )
        g.command 'removeCustomRetention' do |c|
          c.flag 'channel_id', desc: 'The conversation to set the retention policy for.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.admin_conversations_removeCustomRetention(options))
          end
        end

        g.desc 'Rename a public or private channel.'
        g.long_desc %( Rename a public or private channel. )
        g.command 'rename' do |c|
          c.flag 'channel_id', desc: 'The channel to rename.'
          c.flag 'name', desc: '.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.admin_conversations_rename(options))
          end
        end

        g.desc 'Search for public or private channels in an Enterprise organization.'
        g.long_desc %( Search for public or private channels in an Enterprise organization. )
        g.command 'search' do |c|
          c.flag 'connected_team_ids', desc: 'Array of encoded team IDs, signifying the external orgs to search through.'
          c.flag 'cursor', desc: 'Set cursor to next_cursor returned by the previous call to list items in the next page.'
          c.flag 'limit', desc: 'Maximum number of items to be returned. Must be between 1 - 20 both inclusive. Default is 10.'
          c.flag 'query', desc: 'Name of the the channel to query by.'
          c.flag 'search_channel_types', desc: 'The type of channel to include or exclude in the search. For example private will search private channels, while private_exclude will exclude them. For a full list of types, check the Types section.'
          c.flag 'sort', desc: 'Possible values are relevant (search ranking based on what we think is closest), name (alphabetical), member_count (number of users in the channel), and created (date channel was created). You can optionally pair this with the sort_dir arg to change how it is sorted.'
          c.flag 'sort_dir', desc: 'Sort direction. Possible values are asc for ascending order like (1, 2, 3) or (a, b, c), and desc for descending order like (3, 2, 1) or (c, b, a).'
          c.flag 'team_ids', desc: 'Comma separated string of team IDs, signifying the internal workspaces to search through.'
          c.flag 'total_count_only', desc: 'Only return the total_count of channels. Omits channel data and allows access for admins without channel manager permissions.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.admin_conversations_search(options))
          end
        end

        g.desc 'Set the posting permissions for a public or private channel.'
        g.long_desc %( Set the posting permissions for a public or private channel. )
        g.command 'setConversationPrefs' do |c|
          c.flag 'channel_id', desc: 'The channel to set the prefs for.'
          c.flag 'prefs', desc: 'The prefs for this channel in a stringified JSON format.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.admin_conversations_setConversationPrefs(options))
          end
        end

        g.desc "This API endpoint can be used by any admin to set a conversation's retention policy."
        g.long_desc %( This API endpoint can be used by any admin to set a conversation's retention policy. )
        g.command 'setCustomRetention' do |c|
          c.flag 'channel_id', desc: 'The conversation to set the retention policy for.'
          c.flag 'duration_days', desc: 'The message retention duration in days to set for this conversation.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.admin_conversations_setCustomRetention(options))
          end
        end

        g.desc 'Set the workspaces in an Enterprise grid org that connect to a public or private channel.'
        g.long_desc %( Set the workspaces in an Enterprise grid org that connect to a public or private channel. )
        g.command 'setTeams' do |c|
          c.flag 'channel_id', desc: 'The encoded channel_id to add or remove to workspaces.'
          c.flag 'org_channel', desc: 'True if channel has to be converted to an org channel.'
          c.flag 'target_team_ids', desc: 'A comma-separated list of workspaces to which the channel should be shared. Not required if the channel is being shared org-wide.'
          c.flag 'team_id', desc: 'The workspace to which the channel belongs if the channel is a local workspace channel. Omit this argument if the channel is a cross-workspace or org-wide shared channel.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.admin_conversations_setTeams(options))
          end
        end

        g.desc 'Unarchive a public or private channel.'
        g.long_desc %( Unarchive a public or private channel. )
        g.command 'unarchive' do |c|
          c.flag 'channel_id', desc: 'The channel to unarchive.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.admin_conversations_unarchive(options))
          end
        end

        g.desc 'Unlink a Salesforce record from a channel'
        g.long_desc %( Unlink a Salesforce record from a channel )
        g.command 'unlinkObjects' do |c|
          c.flag 'channel', desc: 'Channel ID for Slack channel that will be unlinked from the Salesforce record.'
          c.flag 'new_name', desc: 'Channel name you would like to give to the channel that is being unlinked from the Salesforce record.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.admin_conversations_unlinkObjects(options))
          end
        end
      end
    end
  end
end
