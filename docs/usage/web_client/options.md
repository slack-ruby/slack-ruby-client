---
layout: default
title: Options
parent: Web Client
grand_parent: Usage
nav_order: 2
---

# Options

You can configure the Web client either globally or via the initializer.

```ruby
Slack::Web::Client.configure do |config|
  config.user_agent = 'Slack Ruby Client/1.0'
end
```

```ruby
client = Slack::Web::Client.new(user_agent: 'Slack Ruby Client/1.0')
```

The following settings are supported.

| setting             | description                                                          |
| ------------------- | -------------------------------------------------------------------- |
| token               | Slack API token.                                                     |
| user_agent          | User-agent, defaults to _Slack Ruby Client/version_.                 |
| proxy               | Optional HTTP proxy.                                                 |
| ca_path             | Optional SSL certificates path.                                      |
| ca_file             | Optional SSL certificates file.                                      |
| endpoint            | Slack endpoint, default is _https://slack.com/api_.                  |
| logger              | Optional `Logger` instance that logs HTTP requests.                  |
| timeout             | Optional open/read timeout in seconds.                               |
| open_timeout        | Optional connection open timeout in seconds.                         |
| default_page_size   | Optional page size for paginated requests, default is _100_.         |
| default_max_retries | Optional number of retries for paginated requests, default is _100_. |
| adapter             | Optional HTTP adapter to use, defaults to `Faraday.default_adapter`. |

You can also pass request options, including `timeout` and `open_timeout` into individual calls.

```ruby
client.conversations_list(request: { timeout: 180 })
```

You can also control what proxy options are used by modifying the `http_proxy` environment variable per [Net::HTTP's documentation](https://docs.ruby-lang.org/en/2.0.0/Net/HTTP.html#class-Net::HTTP-label-Proxies).

{: .note }
Docker on OSX seems to incorrectly set the proxy, causing `Faraday::ConnectionFailed, ERROR -- : Failed to open TCP connection to : (getaddrinfo: Name or service not known)`. You might need to manually unset `http_proxy` in that case, eg. `http_proxy="" bundle exec ruby ./my_bot.rb`.
