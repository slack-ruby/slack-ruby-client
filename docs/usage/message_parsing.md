---
layout: home
title: Message Parsing
parent: Usage
nav_order: 5
---

# Message Parsing

All text in Slack uses the same [system of escaping](https://api.slack.com/docs/formatting): chat messages, direct messages, file comments, etc. Use [Slack::Messages::Formatting](https://github.com/slack-ruby/slack-ruby-client/tree/master/lib/slack/messages/formatting.rb) to unescape incoming messages. This comes handy, for example, you want to treat all input to a real time bot as plain text.

```ruby
Slack::Messages::Formatting.unescape('Hello &amp; &lt;world&gt;'))
  # => 'Hello & <world>'
Slack::Messages::Formatting.unescape('Hey <@U024BE7LH|bob>, did you see my file?'))
  # => 'Hey @bob, did you see my file?'
Slack::Messages::Formatting.unescape('Hey <@U02BEFY4U>'))
  # => 'Hey @U02BEFY4U'
Slack::Messages::Formatting.unescape('This message contains a URL <http://foo.com/>'))
  # => 'This message contains a URL http://foo.com/'
Slack::Messages::Formatting.unescape('So does this one: <http://www.foo.com|www.foo.com>'))
  # => 'So does this one: www.foo.com'
Slack::Messages::Formatting.unescape('<mailto:bob@example.com|Bob>'))
  # => 'Bob'
Slack::Messages::Formatting.unescape('Hello <@U123|bob>, say hi to <!everyone> in <#C1234|general>'))
  # => 'Hello @bob, say hi to @everyone in #general'
Slack::Messages::Formatting.unescape('Hello <@U123|bob> &gt; file.txt'))
  # => 'Hello @bob > file.txt'
Slack::Messages::Formatting.unescape('“hello”'))
  # => '"hello"'
Slack::Messages::Formatting.unescape('‘hello’'))
  # => "'hello'"
```
