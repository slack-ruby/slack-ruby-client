# frozen_string_literal: true
# This file was auto-generated by lib/tasks/web.rake

module Slack
  module Web
    module Api
      module Endpoints
        module ConversationsRequestsharedinvite
          #
          # Approves a request to add an external user to a channel and sends them a Slack Connect invite
          #
          # @option options [Object] :invite_id
          #   ID of the requested shared channel invite to approve.
          # @option options [string] :channel_id
          #   Optional channel_id to which external user will be invited to. Will override the value on the requested invite.
          # @option options [boolean] :is_external_limited
          #   Optional boolean on whether the invited team will have post-only permissions in the channel. Will override the value on the requested invite.
          # @option options [object] :message
          #   Object describing the text to send along with the invite. If this object is specified, both text and is_override are required properties. If is_override is set to true, text will override the original invitation message. Otherwise, text will be appended to the original invitation message. The total length of the message cannot exceed 560 characters. If is_override is set to false, the length of text and the user specified message on the invite request in total must be less than 560 characters.
          # @see https://api.slack.com/methods/conversations.requestSharedInvite.approve
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/conversations.requestSharedInvite/conversations.requestSharedInvite.approve.json
          def conversations_requestSharedInvite_approve(options = {})
            raise ArgumentError, 'Required arguments :invite_id missing' if options[:invite_id].nil?
            post('conversations.requestSharedInvite.approve', options)
          end

          #
          # Denies a request to invite an external user to a channel
          #
          # @option options [Object] :invite_id
          #   ID of the requested shared channel invite to deny.
          # @option options [string] :message
          #   Optional message explaining why the request to invite was denied.
          # @see https://api.slack.com/methods/conversations.requestSharedInvite.deny
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/conversations.requestSharedInvite/conversations.requestSharedInvite.deny.json
          def conversations_requestSharedInvite_deny(options = {})
            raise ArgumentError, 'Required arguments :invite_id missing' if options[:invite_id].nil?
            post('conversations.requestSharedInvite.deny', options)
          end

          #
          # Lists requests to add external users to channels with ability to filter.
          #
          # @option options [string] :cursor
          #   Paginate through collections of data by setting the cursor parameter to a next_cursor attribute returned by a previous request's response_metadata. See pagination for more detail.
          # @option options [boolean] :include_approved
          #   When true approved invitation requests will be returned, otherwise they will be excluded.
          # @option options [boolean] :include_denied
          #   When true denied invitation requests will be returned, otherwise they will be excluded.
          # @option options [boolean] :include_expired
          #   When true expired invitation requests will be returned, otherwise they will be excluded.
          # @option options [array] :invite_ids
          #   An optional list of invitation ids to look up.
          # @option options [integer] :limit
          #   The number of items to return. Must be between 1 - 1000 (inclusive).
          # @option options [Object] :user_id
          #   Optional filter to return invitation requests for the inviting user.
          # @see https://api.slack.com/methods/conversations.requestSharedInvite.list
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/conversations.requestSharedInvite/conversations.requestSharedInvite.list.json
          def conversations_requestSharedInvite_list(options = {})
            if block_given?
              Pagination::Cursor.new(self, :conversations_requestSharedInvite_list, options).each do |page|
                yield page
              end
            else
              post('conversations.requestSharedInvite.list', options)
            end
          end
        end
      end
    end
  end
end
