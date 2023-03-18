---
layout: default
title: Pagination
parent: Web Client
grand_parent: Usage
nav_order: 3
---

# Pagination

The Web client natively supports [cursor pagination](https://api.slack.com/docs/pagination#cursors) for methods that allow it, such as `users_list`. Supply a block and the client will make repeated requests adjusting the value of `cursor` with every response. The default limit is set to 100 and can be adjusted via `Slack::Web::Client.config.default_page_size` or by passing it directly into the API call.

```ruby
all_members = []
client.users_list(presence: true, limit: 10) do |response|
  all_members.concat(response.members)
end
all_members # many thousands of team members retrieved 10 at a time
```

When using cursor pagination the client will automatically pause and then retry the request if it runs into Slack rate limiting. (It will pause according to the `Retry-After` header in the 429 response before retrying the request.) If it receives too many rate-limited responses in a row it will give up and raise an error. The default number of retries is 100 and can be adjusted via `Slack::Web::Client.config.default_max_retries` or by passing it directly into the method as `max_retries`.

You can also proactively avoid rate limiting by adding a pause between every paginated request with the `sleep_interval` parameter, which is given in seconds.

```ruby
all_members = []
client.users_list(presence: true, limit: 10, sleep_interval: 5, max_retries: 20) do |response|
  # pauses for 5 seconds between each request
  # gives up after 20 consecutive rate-limited responses
  all_members.concat(response.members)
end
all_members # many thousands of team members retrieved 10 at a time
```
