# frozen_string_literal: true
# This file was auto-generated by lib/tasks/web.rake

module Slack
  module Cli
    class App
      desc 'ConversationsRequestsharedinvite methods.'
      command 'conversations_requestSharedInvite' do |g|
        g.desc 'Approves a request to add an external user to a channel and sends them a Slack Connect invite'
        g.long_desc %( Approves a request to add an external user to a channel and sends them a Slack Connect invite )
        g.command 'approve' do |c|
          c.flag 'invite_id', desc: 'ID of the requested shared channel invite to approve.'
          c.flag 'channel_id', desc: 'Optional channel_id to which external user will be invited to. Will override the value on the requested invite.'
          c.flag 'is_external_limited', desc: 'Optional boolean on whether the invited team will have post-only permissions in the channel. Will override the value on the requested invite.'
          c.flag 'message', desc: 'Object describing the text to send along with the invite. If this object is specified, both text and is_override are required properties. If is_override is set to true, text will override the original invitation message. Otherwise, text will be appended to the original invitation message. The total length of the message cannot exceed 560 characters. If is_override is set to false, the length of text and the user specified message on the invite request in total must be less than 560 characters.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.conversations_requestSharedInvite_approve(options))
          end
        end

        g.desc 'Denies a request to invite an external user to a channel'
        g.long_desc %( Denies a request to invite an external user to a channel )
        g.command 'deny' do |c|
          c.flag 'invite_id', desc: 'ID of the requested shared channel invite to deny.'
          c.flag 'message', desc: 'Optional message explaining why the request to invite was denied.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.conversations_requestSharedInvite_deny(options))
          end
        end

        g.desc 'Lists requests to add external users to channels with ability to filter.'
        g.long_desc %( Lists requests to add external users to channels with ability to filter. )
        g.command 'list' do |c|
          c.flag 'cursor', desc: "Paginate through collections of data by setting the cursor parameter to a next_cursor attribute returned by a previous request's response_metadata. See pagination for more detail."
          c.flag 'include_approved', desc: 'When true approved invitation requests will be returned, otherwise they will be excluded.'
          c.flag 'include_denied', desc: 'When true denied invitation requests will be returned, otherwise they will be excluded.'
          c.flag 'include_expired', desc: 'When true expired invitation requests will be returned, otherwise they will be excluded.'
          c.flag 'invite_ids', desc: 'An optional list of invitation ids to look up.'
          c.flag 'limit', desc: 'The number of items to return. Must be between 1 - 1000 (inclusive).'
          c.flag 'user_id', desc: 'Optional filter to return invitation requests for the inviting user.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.conversations_requestSharedInvite_list(options))
          end
        end
      end
    end
  end
end