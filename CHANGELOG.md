### 0.3.2 (Next)

* Your contribution here.

### 0.3.1 (10/16/2015)

* Added `stars.list`, `add` and `remove` - [@dblock](https://github.com/dblock).
* Added `attachments`, `parse` and `link_names` to `chat.update` - [@dblock](https://github.com/dblock).

### 0.3.0 (9/1/2015)

* Added `team.info` and `accessLogs` - [@dblock](https://github.com/dblock).
* Removed obsolete `presence` API - [@dblock](https://github.com/dblock).
* Added `pins.add`, `list` and `remove` - [@dblock](https://github.com/dblock).
* Added `users.list#presence` - [@dblock](https://github.com/dblock).
* Added `groups.info` - [@dblock](https://github.com/dblock).
* Added `groups.history#inclusive` and `im.history#inclusive` - [@dblock](https://github.com/dblock).
* Added `files.delete` - [@dblock](https://github.com/dblock).
* Added `chat.postMessage#as_user` - [@dblock](https://github.com/dblock).
* Use API reference schema from [github.com/dblock/slack-api-ref](https://github.com/dblock/slack-api-ref) - [@dblock](https://github.com/dblock).
* Added `reactions.add`, `.list`, `.get` and `.remove` - [@jakedahn](https://github.com/jakedahn)

### 0.2.1 (8/2/2015)

* Set Slack API token via `Slack::RealTime::Client.new(token: 'token')` and `Slack::Web::Client.new(token: 'token')` - [@dblock](https://github.com/dblock).
* Set Slack API token via `Slack::RealTime::Client.configure` and `Slack::Web::Client.configure` - [@dblock](https://github.com/dblock).

### 0.2.0 (7/31/2015)

* [#2](https://github.com/dblock/slack-ruby-client/pull/2): `Slack::RealTime::Socket` now pings frames every 30s, as recommended by Slack - [@samdoiron](https://github.com/samdoiron).
* [#3](https://github.com/dblock/slack-ruby-client/issues/3): RealTime client WebSocket frame ping frequency is now configurable with `Slack::RealTime::Client.websocket_ping` - [@dblock](https://github.com/dblock).
* [#3](https://github.com/dblock/slack-ruby-client/issues/3): RealTime client WebSocket proxy is now configurable with `Slack::RealTime::Client.websocket_proxy` - [@dblock](https://github.com/dblock).
* [#3](https://github.com/dblock/slack-ruby-client/issues/3): Added global `Slack::Web::Client` and `Slack::RealTime::Client` configuration options via `Slack::Web::Client.configure` and `Slack::RealTime::Client.configure` - [@dblock](https://github.com/dblock).
* Exposed `Slack::RealTime::Client.url`, `team`, `self`, `users`, `channels`, `groups`, `ims` and `bots` - [@dblock](https://github.com/dblock).
* Default user-agent for `Slack::Web::Client` now includes a slash, eg. _Slack Ruby Client/0.1.1_ - [@dblock](https://github.com/dblock).
* Fix: set `Slack::Web::Client` connection options for `ca_path`, `ca_file`, and `proxy` - [@dblock](https://github.com/dblock).

### 0.1.0 (7/25/2015)

* Initial public release with Web and RealTime Messaging API support - [@dblock](https://github.com/dblock).

