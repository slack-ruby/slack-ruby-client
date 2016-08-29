Slack Ruby Client
=================

[![Gem Version](https://badge.fury.io/rb/slack-ruby-client.svg)](http://badge.fury.io/rb/slack-ruby-client)
[![Build Status](https://travis-ci.org/slack-ruby/slack-ruby-client.svg?branch=master)](https://travis-ci.org/slack-ruby/slack-ruby-client)
[![Code Climate](https://codeclimate.com/github/slack-ruby/slack-ruby-client/badges/gpa.svg)](https://codeclimate.com/github/slack-ruby/slack-ruby-client)

A Ruby client for the Slack [Web](https://api.slack.com/web) and [RealTime Messaging](https://api.slack.com/rtm) APIs. Comes with a handy command-line client, too. If you are not familiar with these concepts, you might want to watch [this video](http://code.dblock.org/2016/03/11/your-first-slack-bot-service-video.html).

![](slack.png)

## Useful to Me?

* This piece of the puzzle will help you send messages to Slack via the Web API and send and receive messages via the Real Time API.
* If you're trying to respond to slash commands, just write a basic web application and use this library to call the Slack Web API.
* If you're trying to build a Real Time bot, use [slack-ruby-bot](https://github.com/dblock/slack-ruby-bot), which uses this library.
* If you're trying to roll out a full service with Slack button integration to multiple teams, check out [slack-ruby-bot-server](https://github.com/dblock/slack-ruby-bot-server), which is built on top of slack-ruby-bot, which uses this library.

## Stable Release

You're reading the documentation for the **stable** release of slack-ruby-client. See [UPGRADING](UPGRADING.md) when upgrading from an older version.

## Installation

Add to Gemfile.

```
gem 'slack-ruby-client'
```

If you're going to be using the RealTime client, add either `eventmachine` and `faye-websocket` or `celluloid-io`. See below for more information about concurrency.

```
gem 'eventmachine'
gem 'faye-websocket'
```

Run `bundle install`.

## Usage

### Create a New Bot Integration

This is something done in Slack, under [integrations](https://my.slack.com/services). Create a [new bot](https://my.slack.com/services/new/bot), and note its API token.

![](screenshots/register-bot.png)

### Use the API Token

```ruby
Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
end
```

This sets a global default token. You can also pass a token into the initializer of both `Slack::Web::Client` and `Slack::RealTime::Client` or configure those separately via `Slack::Web::Config.configure` and `Slack::RealTime::Config.configure`. The instance token will be used over the client type token over the global default.

### Global Settings

The following global settings are supported via `Slack.configure`.

setting      | description
-------------|-------------------------------------------------------------------------------------------------
token        | Slack API token.
logger       | An optional logger, defaults to `::Logger.new(STDOUT)` at `Logger::WARN` level.

### Web Client

The Slack Web API allows you to build applications that interact with Slack.

#### Test Auth

```ruby
client = Slack::Web::Client.new
client.auth_test
```

#### Send Messages

Send messages with [chat_PostMessage](https://api.slack.com/methods/chat.postMessage).

```ruby
client.chat_postMessage(channel: '#general', text: 'Hello World', as_user: true)
```

See a fully working example in [examples/hi_web](examples/hi_web/hi.rb).

![](examples/hi_web/hi.gif)

#### List Channels

List channels with [channels_list](https://api.slack.com/methods/channels.list).

```ruby
channels = client.channels_list.channels

general_channel = channels.detect { |c| c.name == 'general' }
```

#### Upload a File

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

### Get Channel Info

You can use a channel ID or name (prefixed with `#`) in all functions that take a `:channel` argument. Lookup by name is not supported by the Slack API and the `channels_id` method called invokes `channels_list` in order to locate the channel ID.

```ruby
client.channels_info(channel: 'C04KB5X4D') # calls channels_info
```

```ruby
client.channels_info(channel: '#general') # calls channels_list followed by channels_info
```

### Get User Info

You can use a user ID or name (prefixed with `@`) in all functions that take a `:user` argument. Lookup by name is not supported by the Slack API and the `users_id` method called invokes `users_list` in order to locate the user ID.

```ruby
client.users_info(user: 'U092BDCLV') # calls users_info
```

```ruby
client.users_info(user: '@dblock') # calls users_list followed by users_info
```

### Search for a User

Constructs an in-memory index of users and searches it. If you want to use this functionality, add the [picky](https://github.com/floere/picky) gem to your project's Gemfile.

```ruby
client.users_search(user: 'dblock')
```

#### Other

Refer to the [Slack Web API Method Reference](https://api.slack.com/methods) for the list of all available functions.

#### Web Client Options

You can configure the Web client either globally or via the initializer.

```ruby
Slack::Web::Client.config do |config|
  config.user_agent = 'Slack Ruby Client/1.0'
end
```

```ruby
client = Slack::Web::Client.new(user_agent: 'Slack Ruby Client/1.0')
```

The following settings are supported.

setting      | description
-------------|-------------------------------------------------------------------------------------------------
token        | Slack API token.
user_agent   | User-agent, defaults to _Slack Ruby Client/version_.
proxy        | Optional HTTP proxy.
ca_path      | Optional SSL certificates path.
ca_file      | Optional SSL certificates file.
endpoint     | Slack endpoint, default is _https://slack.com/api_.
logger       | Optional `Logger` instance that logs HTTP requests.

### RealTime Client

The Real Time Messaging API is a WebSocket-based API that allows you to receive events from Slack in real time and send messages as user.

```ruby
client = Slack::RealTime::Client.new

client.on :hello do
  puts "Successfully connected, welcome '#{client.self.name}' to the '#{client.team.name}' team at https://#{client.team.domain}.slack.com."
end

client.on :message do |data|
  case data.text
  when 'bot hi' then
    client.message channel: data.channel, text: "Hi <@#{data.user}>!"
  when /^bot/ then
    client.message channel: data.channel, text: "Sorry <@#{data.user}>, what?"
  end
end

client.on :close do |_data|
  puts "Client is about to disconnect"
end

client.on :closed do |_data|
  puts "Client has disconnected successfully!"
end

client.start!
```

You can send typing indicators with `typing`.

```ruby
client.typing channel: data.channel
```

You can send a ping with `ping`.

```ruby
client.ping
```

By default, the RealTime client exposes and maintains a local store with the properties of [rtm.start](https://api.slack.com/methods/rtm.start) upon a successful connection.

property | description
---------|-------------------------------------------------------------------------------------------------
url      | A WebSocket Message Server URL.
self     | The authenticated bot user.
team     | Details on the authenticated user's team.
users    | A hash of user objects by user ID.
channels | A hash of channel objects, one for every channel visible to the authenticated user.
groups   | A hash of group objects, one for every group the authenticated user is in.
ims      | A hash of IM objects, one for every direct message channel visible to the authenticated user.
bots     | Details of the integrations set up on this team.

It also tracks changes, such as users being renamed, added or deleted, therefore `client.users` is always up-to-date.

Tracking with a local store can be disabled with `Slack::RealTime::Client.new(store_class: nil)`. Other stores are also available.

#### Slack::RealTime::Stores::Store

The default store that tracks all changes.

#### Slack::RealTime::Stores::Starter

A smaller store that only stores and tracks information about the bot user, but not channels, users, groups, ims or bots.

### Configuring Slack::RealTime::Client

You can configure the RealTime client either globally or via the initializer.

```ruby
Slack::RealTime::Client.config do |config|
  config.websocket_ping = 42
end
```

```ruby
client = Slack::RealTime::Client.new(websocket_ping: 42)
```

The following settings are supported.

setting         | description
----------------|-----------------------------------------------------------------------------------------------------
token           | Slack API token.
websocket_ping  | The number of seconds that indicates how often the WebSocket should send ping frames, default is 30.
websocket_proxy | Connect via proxy, include `:origin` and `:headers`.
store_class     | Local store class name, default is an in-memory `Slack::RealTime::Stores::Store`.
start_options   | Options to pass into `rtm.start`, default is `{}`.
logger          | Optional `Logger` instance that logs RealTime requests and socket data.

Note that the RealTime client uses a Web client to obtain the WebSocket URL via [rtm.start](https://api.slack.com/methods/rtm.start). While `token` and `logger` options are passed down from the RealTime client, you may also configure Web client options via `Slack::Web::Client.configure` as described above.

See a fully working example in [examples/hi_real_time](examples/hi_real_time/hi.rb).

![](examples/hi_real_time/hi.gif)

### Combining RealTime and Web Clients

Since the Web client is used to obtain the RealTime client's WebSocket URL, you can continue using the Web client in combination with the RealTime client.

```ruby
client = Slack::RealTime::Client.new

client.on :message do |data|
  case data.text
  when 'bot hi' then
    client.web_client.chat_postMessage channel: data.channel, text: "Hi <@#{data.user}>!"
  when /^bot/ then
    client.web_client.chat_postMessage channel: data.channel, text: "Sorry <@#{data.user}>, what?"
  end
end

client.start!
```

See a fullly working example in [examples/hi_real_time_and_web](examples/hi_real_time_and_web/hi.rb).

![](examples/hi_real_time_and_web/hi.gif)

#### Concurrency

`Slack::RealTime::Client` needs help from a concurrency library and supports [Faye::WebSocket](https://github.com/faye/faye-websocket-ruby) with [Eventmachine](https://github.com/eventmachine/eventmachine) and [Celluloid](https://github.com/celluloid/celluloid). It will auto-detect one or the other depending on the gems in your Gemfile, but you can also set concurrency explicitly.

```ruby
Slack::RealTime.configure do |config|
  config.concurrency = Slack::RealTime::Concurrency::Eventmachine
end
```

Use `client.start_async` instead of `client.start!`. A good example of such application is [slack-bot-server](https://github.com/dblock/slack-bot-server).

```ruby
client = Slack::RealTime::Client.new

client.start_async
```

##### Faye::Websocket with Eventmachine

Add the following to your Gemfile.

```
gem 'faye-websocket'
```

See a fully working example in [examples/hi_real_time_async_eventmachine](examples/hi_real_time_async_eventmachine/hi.rb).

##### Celluloid

Add the following to your Gemfile.

```
gem 'celluloid-io', require: ['celluloid/current', 'celluloid/io']
```

See a fully working example in [examples/hi_real_time_async_celluloid](examples/hi_real_time_async_celluloid/hi.rb).

Require

### Message Parsing

All text in Slack uses the same [system of escaping](https://api.slack.com/docs/formatting): chat messages, direct messages, file comments, etc. Use [Slack::Messages::Formatting](lib/slack/messages/formatting.rb) to unescape incoming messages. This comes handy, for example, you want to treat all input to a real time bot as plain text.

```ruby
Slack::Messages::Formatting.unescape('Hello &amp; &lt;world&gt;'))
  # => 'Hello & <world>'
Slack::Messages::Formatting.unescape('Hey <@U024BE7LH|bob>, did you see my file?'))
  # => 'Hey @bob, did you see my file?'
Slack::Messages::Formatting.unescape('Hey <@U02BEFY4U>'))
  # => 'Hey @U02BEFY4U'
Slack::Messages::Formatting.unescape('This message contains a URL <http://foo.com/>'))
  # => 'This message contains a URL http://foo.com/'
Slack::Messages::Formatting.unescape('So does this one: <http://www.foo.com|www.foo.com>'))
  # => 'So does this one: www.foo.com'
Slack::Messages::Formatting.unescape('<mailto:bob@example.com|Bob>'))
  # => 'Bob'
Slack::Messages::Formatting.unescape('Hello <@U123|bob>, say hi to <!everyone> in <#C1234|general>'))
  # => 'Hello @bob, say hi to @everyone in #general'
Slack::Messages::Formatting.unescape('Hello <@U123|bob> &gt; file.txt'))
  # => 'Hello @bob > file.txt'
Slack::Messages::Formatting.unescape('“hello”'))
  # => '"hello"'
Slack::Messages::Formatting.unescape('‘hello’'))
  # => "'hello'"
```

### Command-Line Client

The slack command-line client returns JSON data from the Slack API.

#### Authenticate with Slack

```
$ slack --slack-api-token=[token] auth test
{"ok":true,"url":"...","team":"...","user":"...","team_id":"...","user_id":"..."}
```

#### Send a Message

```
export SLACK_API_TOKEN=...
$ slack chat postMessage --text="hello world" --channel="#general"
{"ok":true,"channel":"...","ts":"...","message":{"text":"hello world","username":"bot","type":"message","subtype":"bot_message","ts":"..."}}
```

#### Get Channel Id

```
$ slack channels id --channel=#general
{"ok":true,"channel":{"id":"C04KB5X4D"}}
```

#### Get Channel Info

```
$ slack channels info --channel=#general
{"ok":true,"channel":{"id":"C04KB5X4D","name":"general", ...}}
```

#### List Users

Combine with [jq](http://stedolan.github.io/jq), a command-line JSON parser.

```
$ slack users list | jq '.members | map({(.id): .name})'
[
  {
    "U04KB5WQR": "dblock"
  },
  {
    "U07518DTL": "rubybot"
  }
]
```

See `slack help` for a complete command-line reference.

## History

This gem is based on [slack-ruby-gem](https://github.com/aki017/slack-ruby-gem), but it more clearly separates the Web and RTM APIs, is more thoroughly tested and is in active development.

## Contributing

See [CONTRIBUTING](CONTRIBUTING.md).

## Copyright and License

Copyright (c) 2015-2016, [Daniel Doubrovkine](https://twitter.com/dblockdotorg), [Artsy](https://www.artsy.net) and [Contributors](CHANGELOG.md).

This project is licensed under the [MIT License](LICENSE.md).
