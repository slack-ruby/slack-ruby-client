Upgrading Slack-Ruby-Client
===========================

### Upgrading to >= 0.5.0

#### Changes to Real Time Concurrency

Since 0.5.0 `Slack::RealTime::Client` supports [Celluloid](https://github.com/celluloid/celluloid) and no longer defaults to [Faye::WebSocket](https://github.com/faye/faye-websocket-ruby) with [Eventmachine](https://github.com/eventmachine/eventmachine). It will auto-detect one or the other depending on the gems in your Gemfile, which means you may need to add one or the other to your Gemfile.

##### Faye::Websocket with Eventmachine

```
gem 'faye-webSocket'
```

##### Celluloid

```
gem 'celluloid-io'
```

When in doubt, use Faye::WebSocket with Eventmachine.

See [#5](https://github.com/dblock/slack-ruby-client/issues/5) for more information.


