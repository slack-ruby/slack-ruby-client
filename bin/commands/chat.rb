# frozen_string_literal: true
# This file was auto-generated by lib/tasks/web.rake

module Slack
  module Cli
    class App
      desc 'Chat methods.'
      command 'chat' do |g|
        g.desc 'Execute a slash command in a public channel (undocumented)'
        g.long_desc %( Execute a slash command in a public channel )
        g.command 'command' do |c|
          c.flag 'channel', desc: 'Channel to execute the command in.'
          c.flag 'command', desc: 'Slash command to be executed. Leading backslash is required.'
          c.flag 'text', desc: 'Additional parameters provided to the slash command.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.chat_command(options))
          end
        end

        g.desc 'Deletes a message.'
        g.long_desc %( Deletes a message. )
        g.command 'delete' do |c|
          c.flag 'channel', desc: 'Channel containing the message to be deleted.'
          c.flag 'ts', desc: 'Timestamp of the message to be deleted.'
          c.flag 'as_user', desc: 'Pass true to delete the message as the authed user with chat:write:user scope. Bot users in this context are considered authed users. If unused or false, the message will be deleted with chat:write:bot scope.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.chat_delete(options))
          end
        end

        g.desc 'Deletes a pending scheduled message from the queue.'
        g.long_desc %( Deletes a pending scheduled message from the queue. )
        g.command 'deleteScheduledMessage' do |c|
          c.flag 'channel', desc: 'The channel the scheduled_message is posting to.'
          c.flag 'scheduled_message_id', desc: 'scheduled_message_id returned from call to chat.scheduleMessage.'
          c.flag 'as_user', desc: 'Pass true to delete the message as the authed user with chat:write:user scope. Bot users in this context are considered authed users. If unused or false, the message will be deleted with chat:write:bot scope.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.chat_deleteScheduledMessage(options))
          end
        end

        g.desc 'Retrieve a permalink URL for a specific extant message'
        g.long_desc %( Retrieve a permalink URL for a specific extant message )
        g.command 'getPermalink' do |c|
          c.flag 'channel', desc: 'The ID of the conversation or channel containing the message.'
          c.flag 'message_ts', desc: "A message's ts value, uniquely identifying it within a channel."
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.chat_getPermalink(options))
          end
        end

        g.desc 'Share a me message into a channel.'
        g.long_desc %( Share a me message into a channel. )
        g.command 'meMessage' do |c|
          c.flag 'channel', desc: 'Channel to send message to. Can be a public channel, private group or IM channel. Can be an encoded ID, or a name.'
          c.flag 'text', desc: 'Text of the message to send.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.chat_meMessage(options))
          end
        end

        g.desc 'Sends an ephemeral message to a user in a channel.'
        g.long_desc %( Sends an ephemeral message to a user in a channel. )
        g.command 'postEphemeral' do |c|
          c.flag 'channel', desc: 'Channel, private group, or IM channel to send message to. Can be an encoded ID, or a name.'
          c.flag 'user', desc: 'id of the user who will receive the ephemeral message. The user should be in the channel specified by the channel argument.'
          c.flag 'attachments', desc: 'A JSON-based array of structured attachments, presented as a URL-encoded string.'
          c.flag 'blocks', desc: 'A JSON-based array of structured blocks, presented as a URL-encoded string.'
          c.flag 'text', desc: 'How this field works and whether it is required depends on other fields you use in your API call. See below for more detail.'
          c.flag 'as_user', desc: '(Legacy) Pass true to post the message as the authed user. Defaults to true if the chat:write:bot scope is not included. Otherwise, defaults to false.'
          c.flag 'icon_emoji', desc: 'Emoji to use as the icon for this message. Overrides icon_url.'
          c.flag 'icon_url', desc: 'URL to an image to use as the icon for this message.'
          c.flag 'link_names', desc: 'Find and link channel names and usernames.'
          c.flag 'parse', desc: 'Change how messages are treated. Defaults to none. See below.'
          c.flag 'thread_ts', desc: "Provide another message's ts value to post this message in a thread. Avoid using a reply's ts value; use its parent's value instead. Ephemeral messages in threads are only shown if there is already an active thread."
          c.flag 'username', desc: "Set your bot's user name."
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.chat_postEphemeral(options))
          end
        end

        g.desc 'Sends a message to a channel.'
        g.long_desc %( Sends a message to a channel. )
        g.command 'postMessage' do |c|
          c.flag 'channel', desc: 'Channel, private group, or IM channel to send message to. Can be an encoded ID, or a name. See below for more details.'
          c.flag 'attachments', desc: 'A JSON-based array of structured attachments, presented as a URL-encoded string.'
          c.flag 'blocks', desc: 'A JSON-based array of structured blocks, presented as a URL-encoded string.'
          c.flag 'text', desc: 'How this field works and whether it is required depends on other fields you use in your API call. See below for more detail.'
          c.flag 'as_user', desc: '(Legacy) Pass true to post the message as the authed user instead of as a bot. Defaults to false. Can only be used by classic Slack apps. See authorship below.'
          c.flag 'icon_emoji', desc: 'Emoji to use as the icon for this message. Overrides icon_url.'
          c.flag 'icon_url', desc: 'URL to an image to use as the icon for this message.'
          c.flag 'link_names', desc: 'Find and link user groups. No longer supports linking individual users; use syntax shown in Mentioning Users instead.'
          c.flag 'metadata', desc: 'JSON object with event_type and event_payload fields, presented as a URL-encoded string. Metadata you post to Slack is accessible to any app or user who is a member of that workspace.'
          c.flag 'mrkdwn', desc: 'Disable Slack markup parsing by setting to false. Enabled by default.'
          c.flag 'parse', desc: 'Change how messages are treated. See below.'
          c.flag 'reply_broadcast', desc: 'Used in conjunction with thread_ts and indicates whether reply should be made visible to everyone in the channel or conversation. Defaults to false.'
          c.flag 'thread_ts', desc: "Provide another message's ts value to make this message a reply. Avoid using a reply's ts value; use its parent instead."
          c.flag 'unfurl_links', desc: 'Pass true to enable unfurling of primarily text-based content.'
          c.flag 'unfurl_media', desc: 'Pass false to disable unfurling of media content.'
          c.flag 'username', desc: "Set your bot's user name."
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.chat_postMessage(options))
          end
        end

        g.desc 'Schedules a message to be sent to a channel.'
        g.long_desc %( Schedules a message to be sent to a channel. )
        g.command 'scheduleMessage' do |c|
          c.flag 'channel', desc: 'Channel, private group, or DM channel to send message to. Can be an encoded ID, or a name. See below for more details.'
          c.flag 'post_at', desc: 'Unix timestamp representing the future time the message should post to Slack.'
          c.flag 'attachments', desc: 'A JSON-based array of structured attachments, presented as a URL-encoded string.'
          c.flag 'blocks', desc: 'A JSON-based array of structured blocks, presented as a URL-encoded string.'
          c.flag 'text', desc: 'How this field works and whether it is required depends on other fields you use in your API call. See below for more detail.'
          c.flag 'as_user', desc: 'Set to true to post the message as the authed user, instead of as a bot. Defaults to false. Cannot be used by new Slack apps. See chat.postMessage.'
          c.flag 'link_names', desc: 'Find and link user groups. No longer supports linking individual users; use syntax shown in Mentioning Users instead.'
          c.flag 'metadata', desc: 'JSON object with event_type and event_payload fields, presented as a URL-encoded string. Metadata you post to Slack is accessible to any app or user who is a member of that workspace.'
          c.flag 'parse', desc: 'Change how messages are treated. See chat.postMessage.'
          c.flag 'reply_broadcast', desc: 'Used in conjunction with thread_ts and indicates whether reply should be made visible to everyone in the channel or conversation. Defaults to false.'
          c.flag 'thread_ts', desc: "Provide another message's ts value to make this message a reply. Avoid using a reply's ts value; use its parent instead."
          c.flag 'unfurl_links', desc: 'Pass true to enable unfurling of primarily text-based content.'
          c.flag 'unfurl_media', desc: 'Pass false to disable unfurling of media content.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.chat_scheduleMessage(options))
          end
        end

        g.desc 'Provide custom unfurl behavior for user-posted URLs'
        g.long_desc %( Provide custom unfurl behavior for user-posted URLs )
        g.command 'unfurl' do |c|
          c.flag 'channel', desc: 'Channel ID of the message. Both channel and ts must be provided together, or unfurl_id and source must be provided together.'
          c.flag 'ts', desc: 'Timestamp of the message to add unfurl behavior to.'
          c.flag 'unfurls', desc: 'URL-encoded JSON map with keys set to URLs featured in the the message, pointing to their unfurl blocks or message attachments.'
          c.flag 'source', desc: 'The source of the link to unfurl. The source may either be composer, when the link is inside the message composer, or conversations_history, when the link has been posted to a conversation.'
          c.flag 'unfurl_id', desc: 'The ID of the link to unfurl. Both unfurl_id and source must be provided together, or channel and ts must be provided together.'
          c.flag 'user_auth_blocks', desc: 'Provide a JSON based array of structured blocks presented as URL-encoded string to send as an ephemeral message to the user as invitation to authenticate further and enable full unfurling behavior.'
          c.flag 'user_auth_message', desc: 'Provide a simply-formatted string to send as an ephemeral message to the user as invitation to authenticate further and enable full unfurling behavior. Provides two buttons, Not now or Never ask me again.'
          c.flag 'user_auth_required', desc: 'Set to true or 1 to indicate the user must install your Slack app to trigger unfurls for this domain.'
          c.flag 'user_auth_url', desc: 'Send users to this custom URL where they will complete authentication in your app to fully trigger unfurling. Value should be properly URL-encoded.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.chat_unfurl(options))
          end
        end

        g.desc 'Updates a message.'
        g.long_desc %( Updates a message. )
        g.command 'update' do |c|
          c.flag 'channel', desc: 'Channel containing the message to be updated.'
          c.flag 'ts', desc: 'Timestamp of the message to be updated.'
          c.flag 'attachments', desc: 'A JSON-based array of structured attachments, presented as a URL-encoded string.'
          c.flag 'blocks', desc: 'A JSON-based array of structured blocks, presented as a URL-encoded string.'
          c.flag 'text', desc: 'How this field works and whether it is required depends on other fields you use in your API call. See below for more detail.'
          c.flag 'as_user', desc: 'Pass true to update the message as the authed user. Bot users in this context are considered authed users.'
          c.flag 'file_ids', desc: 'Array of new file ids that will be sent with this message.'
          c.flag 'link_names', desc: 'Find and link channel names and usernames. Defaults to none. If you do not specify a value for this field, the original value set for the message will be overwritten with the default, none.'
          c.flag 'metadata', desc: "JSON object with event_type and event_payload fields, presented as a URL-encoded string. If you don't include this field, the message's previous metadata will be retained. To remove previous metadata, include an empty object for this field. Metadata you post to Slack is accessible to any app or user who is a member of that workspace."
          c.flag 'parse', desc: 'Change how messages are treated. Defaults to client, unlike chat.postMessage. Accepts either none or full. If you do not specify a value for this field, the original value set for the message will be overwritten with the default, client.'
          c.flag 'reply_broadcast', desc: 'Broadcast an existing thread reply to make it visible to everyone in the channel or conversation.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.chat_update(options))
          end
        end
      end
    end
  end
end
