---
layout: default
title: Configuration
parent: RealTime Client
grand_parent: Usage
nav_order: 1
---

# Configuration

You can configure the RealTime client either globally or via the initializer.

```ruby
Slack::RealTime::Client.configure do |config|
  config.websocket_ping = 42
end
```

```ruby
client = Slack::RealTime::Client.new(websocket_ping: 42)
```

The following settings are supported.

| setting         | description                                                                                                   |
| --------------- | ------------------------------------------------------------------------------------------------------------- |
| token           | Slack API token.                                                                                              |
| websocket_ping  | How long the socket can be idle before sending a ping message to confirm it's still connected, default is 30. |
| websocket_proxy | Connect via proxy, include `:origin` and `:headers`.                                                          |
| start_options   | Options to pass to `rtm.connect`, default is `{ request: { timeout: 180 } }`.                                 |
| store_class     | Local store class, default is an in-memory `Slack::RealTime::Stores::Starter`.                                |
| store_options   | Options to initialize the store, default is `{}`.                                                             |
| logger          | Optional `Logger` instance that logs RealTime requests and socket data.                                       |

{: .note }
The RealTime client uses a Web client to obtain the WebSocket URL via [rtm.connect](https://api.slack.com/methods/rtm.connect). While `token` and `logger` options are passed down from the RealTime client, you may also configure Web client options via `Slack::Web::Client.configure` as described above.

See a fully working example in [examples/hi_real_time_and_web](https://github.com/slack-ruby/slack-ruby-client/tree/master/examples/hi_real_time_and_web/hi.rb).

![Screenshots of RealTime client example.](screenshots/hi.gif)

## Caveats

### `websocket_ping`

This setting determines how long the socket can be idle before sending a ping message to confirm it's still connected.

It's important to note that if a ping message was sent and no response was received within the amount of time specified in `websocket_ping` the client will attempt to reestablish it's connection to the message server.

{: .note}
The ping may take between `websocket_ping` and `websocket_ping * 3/2` seconds to actually trigger when there is no activity on the socket. This is because the timer that checks whether to ping is triggered at every `websocket_ping / 2` interval.

To disable this feature set `websocket_ping` to 0.
