---
layout: default
title: Configuration
parent: Events API
grand_parent: Usage
nav_order: 1
---

# Configuration

You can configure Events support globally.

```ruby
Slack::Events.configure do |config|
  config.signing_secret = 'secret'
end
```

The following settings are supported.

| setting              | description                                                      |
| -------------------- | ---------------------------------------------------------------- |
| signing_secret       | Slack signing secret, defaults is `ENV['SLACK_SIGNING_SECRET']`. |
| signature_expires_in | Signature expiration window in seconds, default is `300`.        |
