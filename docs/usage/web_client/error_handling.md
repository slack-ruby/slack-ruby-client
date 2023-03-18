---
layout: default
title: Error Handling
parent: Web Client
grand_parent: Usage
nav_order: 5
---

# Error Handling

## Slack Errors

If Slack returns an error for the request, then an error will be raised. The error class is specific to the type of error that Slack returns. For instance if Slack returns `account_inactive` then the error will be `Slack::Web::Api::Errors::AccountInactive`. This allows you to handle certain types of errors as needed:

```ruby
rescue Slack::Web::Api::Errors::AccountInactive => e
  # deal with inactive account
end
```

All of these errors inherit from `Slack::Web::Api::Errors::SlackError`, so you can handle or silence all errors if necessary:

```ruby
rescue Slack::Web::Api::Errors::SlackError => e
  # capture all Slack errors
end
```

If there's a new error type that is not yet known by this library, then it will raise `Slack::Web::Api::Errors::SlackError`. (Update the Web API if you find that errors are missing — see [CONTRIBUTING](https://github.com/slack-ruby/slack-ruby-client/tree/master/CONTRIBUTING.md).)

In all of these cases the error message contains the error code, which is also accessible with `slack_error.error`. In case of multiple errors, the error message contains the error codes separated by commas, or they are accessible as an array with `slack_error.errors`. The original response is also accessible using the `response` attribute. The `response_metadata` is accessible with `slack_error.response_metadata`.

## Rate Limiting

If you exceed [Slack’s rate limits](https://api.slack.com/docs/rate-limits), a `Slack::Web::Api::Errors::TooManyRequestsError` will be raised instead. (This does not inherit from `Slack::Web::Api::Errors::SlackError`.)

## Other Errors

When Slack is temporarily unavailable a subclass of `Slack::Web::Api::Errors::ServerError` will be raised and the original `Faraday::Error` will be accesible via `exception.cause`. (Starting with 0.18.0 this is no longer a subclass of `Slack::Web::Api::Errors::SlackError`.)

Specifically `Slack::Web::Api::Errors::ParsingError` will be raised on non-json response (i.e. 200 OK with `Slack unavailable` HTML page) and `Slack::Web::Api::Errors::HttpRequestError` subclasses for connection failures (`Slack::Web::Api::Errors::TimeoutError` for read/open timeouts & `Slack::Web::Api::Errors::UnavailableError` for 5xx HTTP responses).

In any other case, a `Faraday::ClientError` will be raised.
