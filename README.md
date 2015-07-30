Slack Ruby Client
=================

[![Gem Version](https://badge.fury.io/rb/slack-ruby-client.svg)](http://badge.fury.io/rb/slack-ruby-client)
[![Build Status](https://travis-ci.org/dblock/slack-ruby-client.png)](https://travis-ci.org/dblock/slack-ruby-client)

A Ruby client for the Slack [Web](https://api.slack.com/web) and [RealTime Messaging](https://api.slack.com/rtm) APIs.

## Installation

Add to Gemfile.

```
gem 'slack-ruby-client'
```

Run `bundle install`.

## Usage

### Create a New Bot Integration

This is something done in Slack, under [integrations](https://artsy.slack.com/services). Create a [new bot](https://artsy.slack.com/services/new/bot), and note its API token.

![](screenshots/register-bot.png)

### Use the API Token

```ruby
Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
end
```

### Web Client

The Slack Web API allows you to build applications that interact with Slack. For example, send messages with [chat_PostMessage](https://api.slack.com/methods/chat.postMessage).

```ruby
client = Slack::Web::Client.new

client.auth_test

general_channel = client.channels_list['channels'].detect { |c| c['name'] == 't3' }

client.chat_postMessage(channel: general_channel['id'], text: 'Hello World', as_user: true)
```

See a fully working example in [examples/hi_web](examples/hi_web/hi.rb).

![](examples/hi_web/hi.gif)

Refer to the [Slack Web API Method Reference](https://api.slack.com/methods) for the list of all available functions.

### RealTime Client

The Real Time Messaging API is a WebSocket-based API that allows you to receive events from Slack in real time and send messages as user.

```ruby
client = Slack::RealTime::Client.new

client.on :hello do
  puts "Successfully connected, welcome '#{client.self['name']}' to the '#{client.team['name']}' team at https://#{client.team['domain']}.slack.com."
end

client.on :message do |data|
  case data['text']
  when 'bot hi' then
    client.message channel: data['channel'], text: "Hi <@#{data['user']}>!"
  when /^bot/ then
    client.message channel: data['channel'], text: "Sorry <@#{data['user']}>, what?"
  end
end

client.start!
```

You can also send typing indicators.

```ruby
client.typing channel: data['channel']
```

The client exposes the properties of [rtm.start](https://api.slack.com/methods/rtm.start) upon a successful connection.

property | description
---------|-------------------------------------------------------------------------------------------------
url      | A WebSocket Message Server URL.
self     | Details on the authenticated user.
team     | Details on the authenticated user's team.
users    | A list of user objects, one for every member of the team.
channels | A list of channel objects, one for every channel visible to the authenticated user.
groups   | A list of group objects, one for every group the authenticated user is in.
ims      | A list of IM objects, one for every direct message channel visible to the authenticated user.
bots     | Details of the integrations set up on this team.

See a fullly working example in [examples/hi_real_time](examples/hi_real_time/hi.rb).

![](examples/hi_real_time/hi.gif)

### Combinging RealTime and Web Clients

Since the web client is used to obtain the RealTime client's WebSocket URL, you can continue using the web client in combination with the RealTime client.

```ruby
client = Slack::RealTime::Client.new

client.on :message do |data|
  case data['text']
  when 'bot hi' then
    client.web_client.chat_postMessage channel: data['channel'], text: "Hi <@#{data['user']}>!"
  when /^bot/ then
    client.web_client.chat_postMessage channel: data['channel'], text: "Sorry <@#{data['user']}>, what?"
  end
end

client.start!
```

See a fullly working example in [examples/hi_real_time_and_web](examples/hi_real_time_and_web/hi.rb).

![](examples/hi_real_time_and_web/hi.gif)

## History

This gem is based on [slack-ruby-gem](https://github.com/aki017/slack-ruby-gem), but it more clearly separates the Web and RTM APIs, is more thoroughly tested and is in active development.

## Contributing

See [CONTRIBUTING](CONTRIBUTING.md).

## Copyright and License

Copyright (c) 2015, Daniel Doubrovkine, Artsy and [Contributors](CHANGELOG.md).

This project is licensed under the [MIT License](LICENSE.md).
