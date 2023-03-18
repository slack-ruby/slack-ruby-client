---
layout: default
title: Combining RealTime and Web Clients
parent: RealTime Client
grand_parent: Usage
nav_order: 3
---

# Combining RealTime and Web Clients

Since the Web client is used to obtain the RealTime client's WebSocket URL, you can continue using the Web client in combination with the RealTime client.

```ruby
client = Slack::RealTime::Client.new

client.on :message do |data|
  case data.text
  when 'bot hi' then
    client.web_client.chat_postMessage(channel: data.channel, text: "Hi <@#{data.user}>!")
  when /^bot/ then
    client.web_client.chat_postMessage(channel: data.channel, text: "Sorry <@#{data.user}>, what?")
  end
end

client.start!
```

See a fully working example in [examples/hi_real_time_and_web](https://github.com/slack-ruby/slack-ruby-client/tree/master/examples/hi_real_time_and_web/hi.rb).

![Screenshots of RealTime client example.](screenshots/hi.gif)

## Concurrency

`Slack::RealTime::Client` needs help from a concurrency library and supports [Async](https://github.com/socketry/async).

```ruby
Slack::RealTime.configure do |config|
  config.concurrency = Slack::RealTime::Concurrency::Async
end
```

Use `client.start_async` instead of `client.start!`. A good example of such application is [slack-ruby-bot-server](https://github.com/slack-ruby/slack-ruby-bot-server).

```ruby
client = Slack::RealTime::Client.new

client.start_async
```

## Async

Add `async-websocket` to your Gemfile.

```
gem 'async-websocket'
```

See a fully working example in [examples/hi_real_time_async_async](https://github.com/slack-ruby/slack-ruby-client/tree/master/examples/hi_real_time_async_async/hi.rb).
