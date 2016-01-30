Upgrading Slack-Ruby-Client
===========================

### Upgrading to >= 0.6.0

#### Changes to RealTime Local Store

Upon a successful `rtm.start` the RealTime client keeps a local cache of objects, including `self` or `users`. It will now also track changes to these objects. The following changes have been made to the data structures.

##### client.users

The `client.users` collection has been changed from `Array` to `Hash`, with user ID as key. Replace any code iterating over the array with `client.users.values.each` or `client.users.each_pair`.

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


