---
layout: default
title: Store
parent: RealTime Client
grand_parent: Usage
nav_order: 2
---

# Store

The RealTime client exposes and maintains a local store upon successful connection.

Event hooks keep the store's cached data up-to-date.

Tracking with a local store can be disabled with `Slack::RealTime::Client.new(store_class: nil)`.

## `Slack::RealTime::Stores::Starter`

A small store that only caches and tracks data returned in the [rtm.connect](https://api.slack.com/methods/rtm.connect#examples) response.
This store provides `self` and `team` for accessing the limited data about the authenticated user and its workspace, but does not cache other users or bots, channels, or direct messages.

## `Slack::RealTime::Stores::Store`

A more complete store that tracks most changes visible to the authenticated user.

You can see all of the cache types in the table below (each is a hash indexed by its objects' `id`).

| Cache              | Description                                                                                                                                                      |
| ------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `teams`            | Workspaces (teams). Will likely contain only one `team`.                                                                                                         |
| `users`            | All [user](https://api.slack.com/types/user) objects, including `self`.                                                                                          |
| `bots`             | All [bot users](https://api.slack.com/bot-users) (from Slack Apps and legacy custom integrations).                                                               |
| `public_channels`  | Public [conversation](https://api.slack.com/types/conversation) objects.                                                                                         |
| `private_channels` | Private [conversation](https://api.slack.com/types/conversation) and [group](https://api.slack.com/types/group) objects with the authenticated user as a member. |
| `ims`              | Visible [im](https://api.slack.com/types/im) objects, direct message channels with the authenticated user.                                                       |
| `mpims`            | Visible [mpim](https://api.slack.com/types/mpim) objects, multiparty direct message channels that include the authenticated user.                                |

By default, none of these caches are initialized with data beyond what is returned from [rtm.connect](https://api.slack.com/methods/rtm.connect#examples), same as [Slack::RealTime::Stores::Starter](#slackrealtimestoresstarter).
When configured, this store initializes its caches by making additional calls to Web API methods upon successful connection to the RTM API (i.e. "hello" message).

Configure by specifying which caches to fetch:

```ruby
Slack::RealTime::Client.configure do |config|
  config.store_class = Slack::RealTime::Stores::Store
  config.store_options = { caches: %i[teams users public_channels private_channels ims] }
end
```

or with the `:all` option:

```ruby
Slack::RealTime::Client.configure do |config|
  config.store_class = Slack::RealTime::Stores::Store
  config.store_options = { caches: :all }
end
```

{: .note }
For `teams`, this makes a single call to `team.info`, while for `users` and all conversation-like types, this makes paginated calls to `users.list` and `conversations.list` respectively.
Only `bots` requires a separate call for every bot user, so may be slow if your workplace has a lot of bot users.
