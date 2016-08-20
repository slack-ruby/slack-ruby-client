Upgrading Slack-Ruby-Client
===========================

### Upgrading to >= 0.6.0

#### Changes to API Response Data

API responses in both Web and RealTime clients are now instances of [Slack::Messages::Message](lib/slack/messages/message.rb), which provides method access to properties.

Before:

```ruby
puts "Welcome '#{client.self['name']}' to the '#{client.team['name']}' team."
```

After:

```ruby
puts "Welcome #{client.self.name} to the #{client.team.name} team."
```

See [#56](https://github.com/slack-ruby/slack-ruby-client/issues/56) for more information.

#### Changes to RealTime Local Store

Upon a successful `rtm.start` the RealTime client keeps a local cache of objects, including `self` or `users`. It will now also track changes to these objects. The following changes have been made to the data structures.

##### client.self

The `client.self` object is now a `Slack::RealTime::Models::User`, which is a child of `Hashie::Mash`, so no code changes should be required.

##### client.team

The `client.team` object is now a `Slack::RealTime::Models::Team`, which is a child of `Hashie::Mash`, so no code changes should be required.

##### client .users, .channels, .groups, .ims

The `client.users`, `.channels`, `.groups` and `.ims` collections have been changed from `Array` to `Hash`, with object ID as key. Replace any code iterating over the array, eg. `client.users.values.each` or `client.channels.each_pair { |id, channel| ... }`.

See [#55](https://github.com/slack-ruby/slack-ruby-client/issues/55) for more information.

### Upgrading to >= 0.5.0

#### Changes to Real Time Concurrency

Since 0.5.0 `Slack::RealTime::Client` supports [Celluloid](https://github.com/celluloid/celluloid) and no longer defaults to [Faye::WebSocket](https://github.com/faye/faye-websocket-ruby) with [Eventmachine](https://github.com/eventmachine/eventmachine). It will auto-detect one or the other depending on the gems in your Gemfile, which means you may need to add one or the other to your Gemfile.

##### Faye::WebSocket with Eventmachine

```
gem 'faye-websocket'
```

##### Celluloid

```
gem 'celluloid-io'
```

When in doubt, use `faye-websocket`.

See [#5](https://github.com/slack-ruby/slack-ruby-client/issues/5) for more information.


