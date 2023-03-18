---
title: Home
layout: home
nav_order: 1
---

# `slack-ruby-client`

A Ruby and command-line client for the Slack Web, Real Time Messaging and Event APIs.

## Useful to me?

- This library will let you send messages to Slack via the Web API, send and receive messages via the Real Time Messaging API and facilitate integration with the Events API.
- To respond to slash commands, interactive components or events, implement a web application using your favorite web framework and use this library to call the Slack Web API and to verify that events are coming from Slack.
- To build a bot using the Real Time Messaging API, use [slack-ruby-bot](https://github.com/slack-ruby/slack-ruby-bot), which uses this library.
- To roll out a complete service using the Real Time Messaging API with Slack button integration to multiple teams, check out [slack-ruby-bot-server](https://github.com/slack-ruby/slack-ruby-bot-server), which is built on top of slack-ruby-bot, which uses this library.

## History

This gem is based on [slack-ruby-gem](https://github.com/aki017/slack-ruby-gem), but it more clearly separates the Web and RTM APIs, is more thoroughly tested and is in active development.

## Stable Release

{: .info }
You're reading the documentation for the **next** release of `slack-ruby-client`. Please see the documentation for the [last stable release, v2.1.0](/slack-ruby-client/version/v2.1.0/) unless you're integrating with HEAD.

- See [versions]({% link versions.md %}) for docs for a specific relase.
- See [upgrading]({% link upgrading.md %}) when upgrading from an older version.

## Installation

Add to Gemfile.

```
gem 'slack-ruby-client'
```

If you're going to be using the RealTime client, add `async-websocket`. See the documentation for more information about concurrency.

```
gem 'async-websocket', '~> 0.8.0'
```

Run `bundle install`.
