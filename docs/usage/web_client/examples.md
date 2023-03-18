---
layout: default
title: Examples
parent: Web Client
grand_parent: Usage
nav_order: 1
---

# Examples

Here are some examples of how to use the web client with the Web API.

## Test Auth

```ruby
client = Slack::Web::Client.new
client.auth_test
```

## Send Messages

Send messages with [chat_PostMessage](https://api.slack.com/methods/chat.postMessage).

```ruby
client.chat_postMessage(channel: '#general', text: 'Hello World', as_user: true)
```

See a fully working example in [https://github.com/slack-ruby/slack-ruby-client/tree/master/examples/hi_web](examples/hi_web/hi.rb).

![A screenshot of the Web Client hello world example.](screenshots/hi.gif)

## List Channels

List channels with [conversations_list](https://api.slack.com/methods/conversations.list).

```ruby
channels = client.conversations_list.channels

general_channel = channels.detect { |c| c.name == 'general' }
```

## Upload a File

Upload a file with [files_upload](https://api.slack.com/methods/files.upload).

```ruby
client.files_upload(
  channels: '#general',
  as_user: true,
  file: Faraday::UploadIO.new('/path/to/avatar.jpg', 'image/jpeg'),
  title: 'My Avatar',
  filename: 'avatar.jpg',
  initial_comment: 'Attached a selfie.'
)
```

## Get Channel Info

You can use a channel ID or name (prefixed with `#`) in all functions that take a `:channel` argument. Lookup by name is not supported by the Slack API and the `channels_id` method called invokes `conversations_list` in order to locate the channel ID. This invocation can have a cost if you have many Slack channels. In this scenario, we encourage you to use channel id.

```ruby
client.conversations_info(channel: 'C04KB5X4D') # calls conversations_info
```

```ruby
client.conversations_info(channel: '#general') # calls conversations_list followed by conversations_info
```

## Get User Info

You can use a user ID or name (prefixed with `@`) in all functions that take a `:user` argument. Lookup by name is not supported by the Slack API and the `users_id` method called invokes `users_list` in order to locate the user ID.

```ruby
client.users_info(user: 'U092BDCLV') # calls users_info
```

```ruby
client.users_info(user: '@dblock') # calls users_list followed by users_info
```

## Search for a User

Constructs an in-memory index of users and searches it. If you want to use this functionality, add the [picky](https://github.com/floere/picky) gem to your project's Gemfile.

```ruby
client.users_search(user: 'dblock')
```

## Other

Refer to the [Slack Web API Method Reference](https://api.slack.com/methods) for the list of all available functions.
