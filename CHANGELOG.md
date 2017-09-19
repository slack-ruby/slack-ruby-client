### 0.10.0 (9/19/2017)

* [#169](https://github.com/slack-ruby/slack-ruby-client/pull/169): Added [Conversations API](https://api.slack.com/docs/conversations-api) - [@jmanian](https://github.com/jmanian).
* [#169](https://github.com/slack-ruby/slack-ruby-client/pull/169): Added `include_locale` parameter to several methods (`channels_info`, `groups_info`, `im_open`, `rtm_start`, `users_info`, `users_list`) - [@jmanian](https://github.com/jmanian).
* [#169](https://github.com/slack-ruby/slack-ruby-client/pull/169): Removed `groups_close` - [@jmanian](https://github.com/jmanian).
* [#167](https://github.com/slack-ruby/slack-ruby-client/pull/167): Added support for pausing between paginated requests that can cause Slack rate limiting - [@jmanian](https://github.com/jmanian).
* [#163](https://github.com/slack-ruby/slack-ruby-client/pull/164): Use `OpenSSL::X509::DEFAULT_CERT_DIR` and `OpenSSL::X509::DEFAULT_CERT_FILE` for default ca_cert and ca_file - [@leifcr](https://github.com/leifcr).
* [#161](https://github.com/slack-ruby/slack-ruby-client/pull/161): Added support for cursor pagination - [@dblock](https://github.com/dblock).
* [#162](https://github.com/slack-ruby/slack-ruby-client/pull/162): Gracefully close websocket on `Errno::EPIPE` - [@johanoskarsson](https://github.com/johanoskarsson).
* [#172](https://github.com/slack-ruby/slack-ruby-client/pull/172): Use `rtm.start` when store is a subclass of `Slack::RealTime::Stores::Store` (default) - [@kstole](https://github.com/kstole).

### 0.9.1 (8/24/2017)

* [#158](https://github.com/slack-ruby/slack-ruby-client/issues/158): Updated to latest slack-api-ref; Updated chat.3.update patch to reflect argument reordering; Added chat.4.postEphemeral patch to apply the attachments JSON fix (whitespace last line of diff matters! ;-) - [@alexagranov](https://github.com/alexagranov).

### 0.9.0 (8/6/2017)

* [#146](https://github.com/slack-ruby/slack-ruby-client/issues/146): Fix: `undefined method running?` and `ThreadError: Target thread must not be current thread` with `Celluloid::IO` - [@dblock](https://github.com/dblock).
* [#145](https://github.com/slack-ruby/slack-ruby-client/pull/145): Automatically select `rtm_connect` vs. `rtm_start` - [@dblock](https://github.com/dblock).
* [#154](https://github.com/slack-ruby/slack-ruby-client/pull/154): Raise a dedicated error class with 429 responses - [@greggroth](https://github.com/greggroth).
* [#154](https://github.com/slack-ruby/slack-ruby-client/pull/154): Namespace error classes under `Slack::Web::Api::Errors` module - [@greggroth](https://github.com/greggroth).

### 0.8.1 (4/28/2017)

* Added `exclude_members` option to `channels_list` Web API - [@dblock](https://github.com/dblock).
* Added `chat_unfurl` to Web API - [@dblock](https://github.com/dblock).
* Added `rtm_connect` to RTM API - [@dblock](https://github.com/dblock).
* Added `no_latest` support to `rm_start` RTM API - [@dblock](https://github.com/dblock).

### 0.8.0 (3/12/2017)

* [#135](https://github.com/slack-ruby/slack-ruby-client/issues/135): Added `timeout` and `open_timeout` options to Web API - [@dblock](https://github.com/dblock).
* [#134](https://github.com/slack-ruby/slack-ruby-client/issues/134): Set `start_options[:request][:timeout]`, used with `rtm.start` in `Slack::RealTime::Client`, to 180 seconds - [@dblock](https://github.com/dblock).
* [#136](https://github.com/slack-ruby/slack-ruby-client/pull/136): Pass request options in web client calls - [@dblock](https://github.com/dblock).
* [#121](https://github.com/slack-ruby/slack-ruby-client/pull/121): Fix: check that the current Celluloid actor is running before calling `terminate` - [@newdark](https://github.com/newdark).
* [#138](https://github.com/slack-ruby/slack-ruby-client/pull/138): Added `validate` option to `channels_create`, `channels_join`, `channels_rename`, `groups_create` and `groups_rename` Web APIs - [@dblock](https://github.com/dblock).
* [#138](https://github.com/slack-ruby/slack-ruby-client/pull/138): Removed `channel` option from `files_comments_add` Web API - [@dblock](https://github.com/dblock).

### 0.7.9 (2/9/2017)

* [#132](https://github.com/slack-ruby/slack-ruby-client/issues/132): Fix: you are setting a key that conflicts with a built-in method Slack::Messages::Message#presence - [@dblock](https://github.com/dblock).

### 0.7.8 (1/23/2017)

* [#127](https://github.com/slack-ruby/slack-ruby-client/pull/127): Added `thread_ts` and `reply_broadcast` options to `chat_postMessage` in Web API - [@dblock](https://github.com/dblock).
* [#127](https://github.com/slack-ruby/slack-ruby-client/pull/127): Added `channels_replies`, `groups_replies` and `im_replies` to Web API - [@dblock](https://github.com/dblock).
* [#127](https://github.com/slack-ruby/slack-ruby-client/pull/127): Added `goodbye` event to the RTM API - [@dblock](https://github.com/dblock).
* [#127](https://github.com/slack-ruby/slack-ruby-client/pull/127): Added `before` to `team_accessLogs` - [@dblock](https://github.com/dblock).
* [#108](https://github.com/slack-ruby/slack-ruby-client/pull/108): Use slack-ruby-danger gem - [@dblock](https://github.com/dblock).
* [#116](https://github.com/slack-ruby/slack-ruby-client/pull/116): Use [slack-ruby/slack-api-ref](https://github.com/slack-ruby/slack-api-ref) as machine API reference - [@dblock](https://github.com/dblock).
* [#116](https://github.com/slack-ruby/slack-ruby-client/pull/116): Added `users_setPhoto` and `users_deletePhoto` to Web API - [@dblock](https://github.com/dblock).
* [#81](https://github.com/slack-ruby/slack-ruby-client/pull/81): Require faraday 0.9.0 or newer - [@leppert](https://github.com/leppert).
* [#123](https://github.com/slack-ruby/slack-ruby-client/pull/123): Fix a warning about duplicate definitions - [@michaelherold](https://github.com/michaelherold).

### 0.7.7 (8/29/2016)

* [#103](https://github.com/slack-ruby/slack-ruby-client/pull/103): Added Danger, PR linting - [@dblock](https://github.com/dblock).
* [#101](https://github.com/slack-ruby/slack-ruby-client/issues/101): Fix: protected method `close` called with EventMachine - [@dblock](https://github.com/dblock).
* [#104](https://github.com/slack-ruby/slack-ruby-client/issues/104): Fix: thread leak in `start_async` with Celluloid - [@dblock](https://github.com/dblock).

### 0.7.6 (8/7/2016)

* Added `url_verification`, `message.mpim`, `message.im`, `message.groups` and `message.channels` RealTime events - [@dblock](https://github.com/dblock).
* The `im_open` method accepts `return_im` - [@dblock](https://github.com/dblock).

### 0.7.5 (6/27/2016)

* Added `bots_info` to Web API - [@dblock](https://github.com/dblock).
* Added `team_profile_get` and `team_billableInfo` to Web API - [@dblock](https://github.com/dblock).
* Added `chat_meMessage` to Web API - [@dblock](https://github.com/dblock), [@aaronpk](https://github.com/aaronpk).
* Added `users_profile_get` and `users_profile_set` to Web API - [@dblock](https://github.com/dblock).
* The `stars_list` method no longer takes a user - [@dblock](https://github.com/dblock).

### 0.7.4 (5/28/2016)

* [#93](https://github.com/slack-ruby/slack-ruby-client/pull/93): Fix: When using Celluloid concurrency, handle input from the TCP socket asynchronously from reading more - [@benzrf](https://github.com/benzrf).
* Added `auth_revoke` and `users_identity` to Web API - [@dblock](https://github.com/dblock).
* Added `channel` parameter to `files_comments_add` Web API - [@dblock](https://github.com/dblock).

### 0.7.3 (5/14/2016)

* [#90](https://github.com/slack-ruby/slack-ruby-client/issues/90): Fix: Celluloid concurrency handles server-side connection closing - [@dblock](https://github.com/dblock).

### 0.7.2 (5/5/2016)

* [#84](https://github.com/slack-ruby/slack-ruby-client/issues/84): Fix: Celluloid concurrency doesn't parallelize the connection setup - [@dblock](https://github.com/dblock).

### 0.7.1 (5/2/2016)

* [#82](https://github.com/slack-ruby/slack-ruby-client/pull/82): Fix `usergroups.users.{list,update}` and `files.comments.{add,edit,delete}` APIs - [@masatomo](https://github.com/masatomo).
* [#73](https://github.com/slack-ruby/slack-ruby-client/issues/73): Add a `closed` event - [@rkadyb](https://github.com/rkadyb).
* [#69](https://github.com/slack-ruby/slack-ruby-client/issues/69): Add attachments support for `Slack::Web::Api::Endpoints::Chat.chat_update` - [@nicka](https://github.com/nicka).
* [#85](https://github.com/slack-ruby/slack-ruby-client/issues/85): Compatibility with WebMock 2.0 - [@dblock](https://github.com/dblock).
* Added `as_user` to `chat_delete` Web API - [@dblock](https://github.com/dblock).
* Added `reminders_add`, `reminders_complete`, `reminders_delete`, `reminders_info` and `reminders_list` to Web API - [@dblock](https://github.com/dblock).

### 0.7.0 (3/6/2016)

* [#68](https://github.com/slack-ruby/slack-ruby-client/issues/68): The `Slack::RealTime::Config#store_class` is now globally configurable - [@dblock](https://github.com/dblock).
* [#67](https://github.com/slack-ruby/slack-ruby-client/pull/67): Make `logger` configurable and log HTTP requests and responses as well as RealTime events and socket data - [@mikz](https://github.com/mikz), [@dblock](https://github.com/dblock).
* Added `Slack::RealTime::Stores::Store` and `Slack::RealTime::Stores::Starter` - [@dblock](https://github.com/dblock).
* Added `files_revokePublicURL` and `files_sharedPublicURL` to Web API - [@dblock](https://github.com/dblock).
* [#60](https://github.com/slack-ruby/slack-ruby-client/issues/60): Exceptions in event handlers and commands are no longer fatal - [@dblock](https://github.com/dblock).

### 0.6.0 (2/4/2016)

* [#54](https://github.com/slack-ruby/slack-ruby-client/issues/54): RealTime client maintains a local store of team data for `client.self`, `team`, `users`, `channels`, `groups`, `ims` and `bots` data - [@dblock](https://github.com/dblock).
* [#56](https://github.com/slack-ruby/slack-ruby-client/issues/56): API responses in both Web and RealTime clients are now instances of [Slack::Messages::Message](lib/slack/messages/message), which provides method access to properties - [@dblock](https://github.com/dblock).
* [#57](https://github.com/slack-ruby/slack-ruby-client/issues/57): Configure arguments to pass to `rtm.start` via `config.start_options` - [@dblock](https://github.com/dblock).
* [#52](https://github.com/slack-ruby/slack-ruby-client/issues/52): Added `users_search` - [@dblock](https://github.com/dblock).

### 0.5.4 (1/23/2016)

* [#45](https://github.com/slack-ruby/slack-ruby-client/issues/45): Added `channels_id`, `groups_id` and `users_id` - [@dblock](https://github.com/dblock).
* [#45](https://github.com/slack-ruby/slack-ruby-client/issues/45): Automatically lookup channel, group and user ID in Web API methods when Slack API doesn't accept #channel or @user names - [@dblock](https://github.com/dblock).
* [#49](https://github.com/slack-ruby/slack-ruby-client/pull/49): Fix: Celluloid `#connected?` method - [@mikz](https://github.com/mikz), [@kandadaboggu](https://github.com/kandadaboggu).

### 0.5.3 (1/11/2016)

* [#47](https://github.com/slack-ruby/slack-ruby-client/pull/47): Fix: default to Celluloid newer API - [@jlyonsmith](https://github.com/jlyonsmith), [@dblock](https://github.com/dblock).
* Fixed JRuby file encoding regression - [@dblock](https://github.com/dblock).

### 0.5.2 (1/8/2016)

* [#41](https://github.com/slack-ruby/slack-ruby-client/issues/41): Added `Slack::Messages::Formatting#unescape` - [@dblock](https://github.com/dblock).
* Added `files_comments` to Web API - [@dblock](https://github.com/dblock).

### 0.5.1 (1/4/2016)

* Added `dnd_teamInfo`, `dnd_setSnooze`, `dnd_info`, `dnd_endSnooze` and `dnd_endDnd` to Web API - [@dblock](https://github.com/dblock).
* The `files_upload` method now requires both `file` and `filename` to Web API - [@dblock](https://github.com/dblock).

### 0.5.0 (12/7/2015)

* Added `usergroups_create`, `usergroups_disable`, `usergroups_enable`, `usergroups_list`, `usergroups_update` and `usergroups_users` to Web API - [@dblock](https://github.com/dblock).
* Added command-line `slack` client - [@dblock](https://github.com/dblock).
* [#5](https://github.com/slack-ruby/slack-ruby-client/issues/5): Added Celluloid support - [@mikz](https://github.com/mikz), [@dblock](https://github.com/dblock).
* [#34](https://github.com/slack-ruby/slack-ruby-client/pull/34): Added `Slack::RealTime::Client#start_async` - [@mikz](https://github.com/mikz), [@dblock](https://github.com/dblock).
* `Slack::RealTime::Client` supports `:open` and `:close` callbacks - [@dblock](https://github.com/dblock).
* [#32](https://github.com/slack-ruby/slack-ruby-client/issues/32): Fix: `on_complete: undefined method [] for nil:NilClass` when responding to Slack 400-500 errors - [@dblock](https://github.com/dblock).
* [#22](https://github.com/slack-ruby/slack-ruby-client/issues/22): Added `Slack::Web::Api::Error#response` - [@dblock](https://github.com/dblock).
* Added `logger` to `Slack::Web::Client` configuration that logs HTTP requests - [@dblock](https://github.com/dblock).

### 0.4.0 (11/8/2015)

* Added `team_integrationLogs` to Web API - [@dblock](https://github.com/dblock).
* [#11](https://github.com/slack-ruby/slack-ruby-client/pull/11): Web API `chat_postMessage` errors only if both `attachments` and `text` are missing - [@dblock](https://github.com/dblock).
* [#20](https://github.com/slack-ruby/slack-ruby-client/issues/20): Web API `chat_postMessage` will automatically `to_json` attachments - [@dblock](https://github.com/dblock).
* Added `mpim_aware` to `rtm_start` to Web API - [@dblock](https://github.com/dblock).
* Added `mpim_close`, `mpim_history`, `mpim_list`, `mpim_mark` and `mpim_open` to Web API - [@dblock](https://github.com/dblock).
* Added `unreads` to `channels_history`, `groups_history` and `im_history` to Web API - [@dblock](https://github.com/dblock).
* Added `stars_add` and `stars_remove` to Web API - [@dblock](https://github.com/dblock).

### 0.3.1 (10/16/2015)

* Added `stars_list`, `stars_add` and `stars_remove` to Web API - [@dblock](https://github.com/dblock).
* Added `attachments`, `parse` and `link_names` to `chat_update` in Web API - [@dblock](https://github.com/dblock).

### 0.3.0 (9/1/2015)

* Added `team.info` and `accessLogs` to Web API - [@dblock](https://github.com/dblock).
* Removed obsolete `presence` Web API - [@dblock](https://github.com/dblock).
* Added `pins_add`, `pins_list` and `pins_remove` from Web API - [@dblock](https://github.com/dblock).
* Added `presence` to `users_list` in Web API - [@dblock](https://github.com/dblock).
* Added `groups_info` to Web API - [@dblock](https://github.com/dblock).
* Added `inclusive` to `groups_history` and `im_history` in Web API - [@dblock](https://github.com/dblock).
* Added `files_delete` to Web API - [@dblock](https://github.com/dblock).
* Added `as_user` to `chat_postMessage` in Web API - [@dblock](https://github.com/dblock).
* Use API reference schema from [github.com/dblock/slack-api-ref](https://github.com/dblock/slack-api-ref) - [@dblock](https://github.com/dblock).
* Added `reactions_add`, `reactions_list`, `reactions_get` and `reactions_remove` to Web API - [@jakedahn](https://github.com/jakedahn).

### 0.2.1 (8/2/2015)

* Set Slack API token via `Slack::RealTime::Client.new(token: 'token')` and `Slack::Web::Client.new(token: 'token')` - [@dblock](https://github.com/dblock).
* Set Slack API token via `Slack::RealTime::Client.configure` and `Slack::Web::Client.configure` - [@dblock](https://github.com/dblock).

### 0.2.0 (7/31/2015)

* [#2](https://github.com/slack-ruby/slack-ruby-client/pull/2): `Slack::RealTime::Socket` now pings frames every 30s, as recommended by Slack - [@samdoiron](https://github.com/samdoiron).
* [#3](https://github.com/slack-ruby/slack-ruby-client/issues/3): RealTime client WebSocket frame ping frequency is now configurable with `Slack::RealTime::Client.websocket_ping` - [@dblock](https://github.com/dblock).
* [#3](https://github.com/slack-ruby/slack-ruby-client/issues/3): RealTime client WebSocket proxy is now configurable with `Slack::RealTime::Client.websocket_proxy` - [@dblock](https://github.com/dblock).
* [#3](https://github.com/slack-ruby/slack-ruby-client/issues/3): Added global `Slack::Web::Client` and `Slack::RealTime::Client` configuration options via `Slack::Web::Client.configure` and `Slack::RealTime::Client.configure` - [@dblock](https://github.com/dblock).
* Exposed `Slack::RealTime::Client.url`, `team`, `self`, `users`, `channels`, `groups`, `ims` and `bots` - [@dblock](https://github.com/dblock).
* Default user-agent for `Slack::Web::Client` now includes a slash, eg. _Slack Ruby Client/0.1.1_ - [@dblock](https://github.com/dblock).
* Fix: set `Slack::Web::Client` connection options for `ca_path`, `ca_file`, and `proxy` - [@dblock](https://github.com/dblock).

### 0.1.0 (7/25/2015)

* Initial public release with Web and RealTime Messaging API support - [@dblock](https://github.com/dblock).
