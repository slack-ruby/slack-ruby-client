---
layout: default
title: Verifying the Request Signature
parent: Events API
grand_parent: Usage
nav_order: 2
---

# Verifying the Request Signature

Slack signs its requests using a secret that's unique to your app. Verify incoming HTTP requests as follows.

```ruby
slack_request = Slack::Events::Request.new(http_request)
slack_request.verify!
```

To specify secrets on a per-request basis:

```ruby
Slack::Events::Request.new(http_request,
                           signing_secret: signing_secret,
                           signature_expires_in: signature_expires_in)
```

The `verify!` call may raise `Slack::Events::Request::MissingSigningSecret`, `Slack::Events::Request::InvalidSignature` or `Slack::Events::Request::TimestampExpired` errors.
