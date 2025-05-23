# frozen_string_literal: true
# This file was auto-generated by lib/tasks/web.rake

module Slack
  module Web
    module Api
      module Endpoints
        module Conversations
          #
          # Accepts an invitation to a Slack Connect channel.
          #
          # @option options [string] :channel_name
          #   Name of the channel. If the channel does not exist already in your workspace, this name is the one that the channel will take.
          # @option options [Object] :channel_id
          #   ID of the channel that you'd like to accept. Must provide either invite_id or channel_id.
          # @option options [boolean] :free_trial_accepted
          #   Whether you'd like to use your workspace's free trial to begin using Slack Connect.
          # @option options [Object] :invite_id
          #   ID of the invite that you'd like to accept. Must provide either invite_id or channel_id. See the shared_channel_invite_received event payload for more details on how to retrieve the ID of the invitation.
          # @option options [boolean] :is_private
          #   Whether the channel should be private.
          # @option options [Object] :team_id
          #   The ID of the workspace to accept the channel in. If an org-level token is used to call this method, the team_id argument is required.
          # @see https://api.slack.com/methods/conversations.acceptSharedInvite
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/conversations/conversations.acceptSharedInvite.json
          def conversations_acceptSharedInvite(options = {})
            raise ArgumentError, 'Required arguments :channel_name missing' if options[:channel_name].nil?
            post('conversations.acceptSharedInvite', options)
          end

          #
          # Approves an invitation to a Slack Connect channel
          #
          # @option options [Object] :invite_id
          #   ID of the shared channel invite to approve.
          # @option options [Object] :target_team
          #   The team or enterprise id of the other party involved in the invitation you are approving.
          # @see https://api.slack.com/methods/conversations.approveSharedInvite
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/conversations/conversations.approveSharedInvite.json
          def conversations_approveSharedInvite(options = {})
            raise ArgumentError, 'Required arguments :invite_id missing' if options[:invite_id].nil?
            post('conversations.approveSharedInvite', options)
          end

          #
          # Archives a conversation.
          #
          # @option options [channel] :channel
          #   ID of conversation to archive.
          # @see https://api.slack.com/methods/conversations.archive
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/conversations/conversations.archive.json
          def conversations_archive(options = {})
            raise ArgumentError, 'Required arguments :channel missing' if options[:channel].nil?
            options = options.merge(channel: conversations_id(options)['channel']['id']) if options[:channel]
            post('conversations.archive', options)
          end

          #
          # Closes a direct message or multi-person direct message.
          #
          # @option options [channel] :channel
          #   Conversation to close.
          # @see https://api.slack.com/methods/conversations.close
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/conversations/conversations.close.json
          def conversations_close(options = {})
            raise ArgumentError, 'Required arguments :channel missing' if options[:channel].nil?
            options = options.merge(channel: conversations_id(options)['channel']['id']) if options[:channel]
            post('conversations.close', options)
          end

          #
          # Initiates a public or private channel-based conversation
          #
          # @option options [string] :name
          #   Name of the public or private channel to create.
          # @option options [boolean] :is_private
          #   Create a private channel instead of a public one.
          # @option options [string] :team_id
          #   encoded team id to create the channel in, required if org token is used.
          # @see https://api.slack.com/methods/conversations.create
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/conversations/conversations.create.json
          def conversations_create(options = {})
            raise ArgumentError, 'Required arguments :name missing' if options[:name].nil?
            post('conversations.create', options)
          end

          #
          # Declines a Slack Connect channel invite.
          #
          # @option options [Object] :invite_id
          #   ID of the Slack Connect invite to decline. Subscribe to the shared_channel_invite_accepted event to receive IDs of Slack Connect channel invites that have been accepted and are awaiting approval.
          # @option options [Object] :target_team
          #   The team or enterprise id of the other party involved in the invitation you are declining.
          # @see https://api.slack.com/methods/conversations.declineSharedInvite
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/conversations/conversations.declineSharedInvite.json
          def conversations_declineSharedInvite(options = {})
            raise ArgumentError, 'Required arguments :invite_id missing' if options[:invite_id].nil?
            post('conversations.declineSharedInvite', options)
          end

          #
          # Fetches a conversation's history of messages and events.
          #
          # @option options [channel] :channel
          #   Conversation ID to fetch history for.
          # @option options [string] :cursor
          #   Paginate through collections of data by setting the cursor parameter to a next_cursor attribute returned by a previous request's response_metadata. Default value fetches the first "page" of the collection. See pagination for more detail.
          # @option options [boolean] :include_all_metadata
          #   Return all metadata associated with this message.
          # @option options [boolean] :inclusive
          #   Include messages with oldest or latest timestamps in results. Ignored unless either timestamp is specified.
          # @option options [timestamp] :latest
          #   Only messages before this Unix timestamp will be included in results. Default is the current time.
          # @option options [number] :limit
          #   The maximum number of items to return. Fewer than the requested number of items may be returned, even if the end of the conversation history hasn't been reached. Maximum of 999.
          # @option options [timestamp] :oldest
          #   Only messages after this Unix timestamp will be included in results.
          # @see https://api.slack.com/methods/conversations.history
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/conversations/conversations.history.json
          def conversations_history(options = {})
            raise ArgumentError, 'Required arguments :channel missing' if options[:channel].nil?
            options = options.merge(channel: conversations_id(options)['channel']['id']) if options[:channel]
            if block_given?
              Pagination::Cursor.new(self, :conversations_history, options).each do |page|
                yield page
              end
            else
              post('conversations.history', options)
            end
          end

          #
          # Retrieve information about a conversation.
          #
          # @option options [channel] :channel
          #   Conversation ID to learn more about.
          # @option options [boolean] :include_locale
          #   Set this to true to receive the locale for this conversation. Defaults to false.
          # @option options [boolean] :include_num_members
          #   Set to true to include the member count for the specified conversation. Defaults to false.
          # @see https://api.slack.com/methods/conversations.info
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/conversations/conversations.info.json
          def conversations_info(options = {})
            raise ArgumentError, 'Required arguments :channel missing' if options[:channel].nil?
            options = options.merge(channel: conversations_id(options)['channel']['id']) if options[:channel]
            post('conversations.info', options)
          end

          #
          # Invites users to a channel.
          #
          # @option options [channel] :channel
          #   The ID of the public or private channel to invite user(s) to.
          # @option options [string] :users
          #   A comma separated list of user IDs. Up to 1000 users may be listed.
          # @option options [boolean] :force
          #   When set to true and multiple user IDs are provided, continue inviting the valid ones while disregarding invalid IDs. Defaults to false.
          # @see https://api.slack.com/methods/conversations.invite
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/conversations/conversations.invite.json
          def conversations_invite(options = {})
            raise ArgumentError, 'Required arguments :channel missing' if options[:channel].nil?
            raise ArgumentError, 'Required arguments :users missing' if options[:users].nil?
            options = options.merge(channel: conversations_id(options)['channel']['id']) if options[:channel]
            post('conversations.invite', options)
          end

          #
          # Sends an invitation to a Slack Connect channel
          #
          # @option options [channel] :channel
          #   ID of the channel on your team that you'd like to share.
          # @option options [array] :emails
          #   Optional email to receive this invite. Either emails or user_ids must be provided. Only one email or one user ID may be invited at a time.
          # @option options [boolean] :external_limited
          #   Optional boolean on whether invite is to an external limited member. Defaults to true.
          # @option options [array] :user_ids
          #   Optional user_id to receive this invite. Either emails or user_ids must be provided. Only one email or one user ID may be invited at a time.
          # @see https://api.slack.com/methods/conversations.inviteShared
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/conversations/conversations.inviteShared.json
          def conversations_inviteShared(options = {})
            raise ArgumentError, 'Required arguments :channel missing' if options[:channel].nil?
            options = options.merge(channel: conversations_id(options)['channel']['id']) if options[:channel]
            post('conversations.inviteShared', options)
          end

          #
          # Joins an existing conversation.
          #
          # @option options [channel] :channel
          #   ID of conversation to join.
          # @see https://api.slack.com/methods/conversations.join
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/conversations/conversations.join.json
          def conversations_join(options = {})
            raise ArgumentError, 'Required arguments :channel missing' if options[:channel].nil?
            options = options.merge(channel: conversations_id(options)['channel']['id']) if options[:channel]
            post('conversations.join', options)
          end

          #
          # Removes a user from a conversation.
          #
          # @option options [channel] :channel
          #   ID of conversation to remove user from.
          # @option options [user] :user
          #   User ID to be removed.
          # @see https://api.slack.com/methods/conversations.kick
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/conversations/conversations.kick.json
          def conversations_kick(options = {})
            raise ArgumentError, 'Required arguments :channel missing' if options[:channel].nil?
            options = options.merge(channel: conversations_id(options)['channel']['id']) if options[:channel]
            options = options.merge(user: users_id(options)['user']['id']) if options[:user]
            post('conversations.kick', options)
          end

          #
          # Leaves a conversation.
          #
          # @option options [channel] :channel
          #   Conversation to leave.
          # @see https://api.slack.com/methods/conversations.leave
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/conversations/conversations.leave.json
          def conversations_leave(options = {})
            raise ArgumentError, 'Required arguments :channel missing' if options[:channel].nil?
            options = options.merge(channel: conversations_id(options)['channel']['id']) if options[:channel]
            post('conversations.leave', options)
          end

          #
          # Lists all channels in a Slack team.
          #
          # @option options [string] :cursor
          #   Paginate through collections of data by setting the cursor parameter to a next_cursor attribute returned by a previous request's response_metadata. Default value fetches the first "page" of the collection. See pagination for more detail.
          # @option options [boolean] :exclude_archived
          #   Set to true to exclude archived channels from the list.
          # @option options [number] :limit
          #   The maximum number of items to return. Fewer than the requested number of items may be returned, even if the end of the list hasn't been reached. Must be an integer under 1000.
          # @option options [string] :team_id
          #   encoded team id to list channels in, required if token belongs to org-wide app.
          # @option options [string] :types
          #   Mix and match channel types by providing a comma-separated list of any combination of public_channel, private_channel, mpim, im.
          # @see https://api.slack.com/methods/conversations.list
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/conversations/conversations.list.json
          def conversations_list(options = {})
            if block_given?
              Pagination::Cursor.new(self, :conversations_list, options).each do |page|
                yield page
              end
            else
              post('conversations.list', options)
            end
          end

          #
          # Lists shared channel invites that have been generated or received but have not been approved by all parties
          #
          # @option options [string] :cursor
          #   Set to next_cursor returned by previous call to list items in subsequent page.
          # @option options [string] :team_id
          #   Encoded team id for the workspace to retrieve invites for, required if org token is used.
          # @see https://api.slack.com/methods/conversations.listConnectInvites
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/conversations/conversations.listConnectInvites.json
          def conversations_listConnectInvites(options = {})
            if block_given?
              Pagination::Cursor.new(self, :conversations_listConnectInvites, options).each do |page|
                yield page
              end
            else
              post('conversations.listConnectInvites', options)
            end
          end

          #
          # Sets the read cursor in a channel.
          #
          # @option options [channel] :channel
          #   Channel or conversation to set the read cursor for.
          # @option options [timestamp] :ts
          #   Unique identifier of message you want marked as most recently seen in this conversation.
          # @see https://api.slack.com/methods/conversations.mark
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/conversations/conversations.mark.json
          def conversations_mark(options = {})
            raise ArgumentError, 'Required arguments :channel missing' if options[:channel].nil?
            raise ArgumentError, 'Required arguments :ts missing' if options[:ts].nil?
            options = options.merge(channel: conversations_id(options)['channel']['id']) if options[:channel]
            post('conversations.mark', options)
          end

          #
          # Retrieve members of a conversation.
          #
          # @option options [channel] :channel
          #   ID of the conversation to retrieve members for.
          # @option options [string] :cursor
          #   Paginate through collections of data by setting the cursor parameter to a next_cursor attribute returned by a previous request's response_metadata. Default value fetches the first "page" of the collection. See pagination for more detail.
          # @option options [number] :limit
          #   The maximum number of items to return. Fewer than the requested number of items may be returned, even if the end of the users list hasn't been reached.
          # @see https://api.slack.com/methods/conversations.members
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/conversations/conversations.members.json
          def conversations_members(options = {})
            raise ArgumentError, 'Required arguments :channel missing' if options[:channel].nil?
            options = options.merge(channel: conversations_id(options)['channel']['id']) if options[:channel]
            if block_given?
              Pagination::Cursor.new(self, :conversations_members, options).each do |page|
                yield page
              end
            else
              post('conversations.members', options)
            end
          end

          #
          # Opens or resumes a direct message or multi-person direct message.
          #
          # @option options [channel] :channel
          #   Resume a conversation by supplying an im or mpim's ID. Or provide the users field instead.
          # @option options [boolean] :prevent_creation
          #   Do not create a direct message or multi-person direct message. This is used to see if there is an existing dm or mpdm.
          # @option options [boolean] :return_im
          #   Boolean, indicates you want the full IM channel definition in the response.
          # @option options [string] :users
          #   Comma separated lists of users. If only one user is included, this creates a 1:1 DM.  The ordering of the users is preserved whenever a multi-person direct message is returned. Supply a channel when not supplying users.
          # @see https://api.slack.com/methods/conversations.open
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/conversations/conversations.open.json
          def conversations_open(options = {})
            options = options.merge(channel: conversations_id(options)['channel']['id']) if options[:channel]
            post('conversations.open', options)
          end

          #
          # Renames a conversation.
          #
          # @option options [channel] :channel
          #   ID of conversation to rename.
          # @option options [string] :name
          #   New name for conversation.
          # @see https://api.slack.com/methods/conversations.rename
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/conversations/conversations.rename.json
          def conversations_rename(options = {})
            raise ArgumentError, 'Required arguments :channel missing' if options[:channel].nil?
            raise ArgumentError, 'Required arguments :name missing' if options[:name].nil?
            options = options.merge(channel: conversations_id(options)['channel']['id']) if options[:channel]
            post('conversations.rename', options)
          end

          #
          # Retrieve a thread of messages posted to a conversation
          #
          # @option options [channel] :channel
          #   Conversation ID to fetch thread from.
          # @option options [timestamp] :ts
          #   Unique identifier of either a thread's parent message or a message in the thread. ts must be the timestamp of an existing message with 0 or more replies. If there are no replies then just the single message referenced by ts will return - it is just an ordinary, unthreaded message.
          # @option options [string] :cursor
          #   Paginate through collections of data by setting the cursor parameter to a next_cursor attribute returned by a previous request's response_metadata. Default value fetches the first "page" of the collection. See pagination for more detail.
          # @option options [boolean] :include_all_metadata
          #   Return all metadata associated with this message.
          # @option options [boolean] :inclusive
          #   Include messages with oldest or latest timestamps in results. Ignored unless either timestamp is specified.
          # @option options [timestamp] :latest
          #   Only messages before this Unix timestamp will be included in results.
          # @option options [number] :limit
          #   The maximum number of items to return. Fewer than the requested number of items may be returned, even if the end of the users list hasn't been reached.
          # @option options [timestamp] :oldest
          #   Only messages after this Unix timestamp will be included in results.
          # @see https://api.slack.com/methods/conversations.replies
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/conversations/conversations.replies.json
          def conversations_replies(options = {})
            raise ArgumentError, 'Required arguments :channel missing' if options[:channel].nil?
            raise ArgumentError, 'Required arguments :ts missing' if options[:ts].nil?
            options = options.merge(channel: conversations_id(options)['channel']['id']) if options[:channel]
            if block_given?
              Pagination::Cursor.new(self, :conversations_replies, options).each do |page|
                yield page
              end
            else
              post('conversations.replies', options)
            end
          end

          #
          # Sets the channel description.
          #
          # @option options [channel] :channel
          #   Channel to set the description of.
          # @option options [string] :purpose
          #   The description.
          # @see https://api.slack.com/methods/conversations.setPurpose
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/conversations/conversations.setPurpose.json
          def conversations_setPurpose(options = {})
            raise ArgumentError, 'Required arguments :channel missing' if options[:channel].nil?
            raise ArgumentError, 'Required arguments :purpose missing' if options[:purpose].nil?
            options = options.merge(channel: conversations_id(options)['channel']['id']) if options[:channel]
            post('conversations.setPurpose', options)
          end

          #
          # Sets the topic for a conversation.
          #
          # @option options [channel] :channel
          #   Conversation to set the topic of.
          # @option options [string] :topic
          #   The new topic string. Does not support formatting or linkification.
          # @see https://api.slack.com/methods/conversations.setTopic
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/conversations/conversations.setTopic.json
          def conversations_setTopic(options = {})
            raise ArgumentError, 'Required arguments :channel missing' if options[:channel].nil?
            raise ArgumentError, 'Required arguments :topic missing' if options[:topic].nil?
            options = options.merge(channel: conversations_id(options)['channel']['id']) if options[:channel]
            post('conversations.setTopic', options)
          end

          #
          # Reverses conversation archival.
          #
          # @option options [channel] :channel
          #   ID of conversation to unarchive.
          # @see https://api.slack.com/methods/conversations.unarchive
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/conversations/conversations.unarchive.json
          def conversations_unarchive(options = {})
            raise ArgumentError, 'Required arguments :channel missing' if options[:channel].nil?
            options = options.merge(channel: conversations_id(options)['channel']['id']) if options[:channel]
            post('conversations.unarchive', options)
          end
        end
      end
    end
  end
end
