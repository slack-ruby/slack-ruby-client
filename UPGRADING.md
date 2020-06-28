Upgrading Slack-Ruby-Client
===========================

### Upgrading to >= 0.15.0

As of 0.15.0, `activesupport` is no longer required. Add `gem 'activesupport'` to your Gemfile if you required ActiveSupport via this library.

See [#325](https://github.com/slack-ruby/slack-ruby-client/pull/325) for more information.

### Upgrading to >= 0.14.0

If you are using async-websocket, lock down its version to 0.8.0 as newer versions are currently incompatible.

```
gem 'async-websocket', '~> 0.8.0'
```

See [#282](https://github.com/slack-ruby/slack-ruby-client/issues/282) for more information.

### Upgrading to >= 0.13.0

#### Recommended Async Library

The RealTime client now supports [async-websocket](https://github.com/socketry/async-websocket), which is actively maintained and is now the recommended library.

See [#219](https://github.com/slack-ruby/slack-ruby-client/pull/219) for implementation details.

#### Async Library Threading and Reactor Changes

The RealTime celluloid-io implementation now uses a `Thread` per client. Previous versions used an `Actor`.

The faye-websocket implementation with EventMachine will attempt to shutdown EventMachine via `EventMachine.stop` upon shutdown if a reactor wasn't already running.

See [#224](https://github.com/slack-ruby/slack-ruby-client/pull/224) for more information.

### Upgrading to >= 0.9.0

#### Changes in How the RTM Client Connects

The RealTime client now automatically chooses either [rtm.start](https://api.slack.com/methods/rtm.start) or [rtm.connect](https://api.slack.com/methods/rtm.connect) to open a connection. The `rtm.connect` method is a newer, preferred method, which serves connection purposes and returns some basic team info. The `rtm.start` method additionally returns a lot of data about the team, its channels, and members, and is required to use the full `Slack::RealTime::Stores::Store` storage class.

Prior versions always used `rtm.start`, to restore this behavior, configure `start_method`.

```ruby
Slack::RealTime::Client.config do |config|
  config.start_method = :rtm_start
end
```

See [#145](https://github.com/slack-ruby/slack-ruby-client/pull/145) for more information.

### Upgrading to >= 0.8.0

The default timeout for `rtm.start` has been increased from 60 to 180 seconds via `Slack::RealTime::Client.config.start_options[:request][:timeout]`. If you're explicitly setting `start_options` in your application, preserve the value by merging settings instead of replacing the entire `start_options` value.

Before:

```ruby
Slack::RealTime::Client.config do |config|
  config.start_options = { no_unreads: true }
end
```

After:

```ruby
Slack::RealTime::Client.config do |config|
  config.start_options[:no_unreads] = true # keeps config.start_options[:request] intact
end
```

See [#136](https://github.com/slack-ruby/slack-ruby-client/pull/136) for more information.

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


