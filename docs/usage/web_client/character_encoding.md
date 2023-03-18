---
layout: default
title: Character Encoding
parent: Web Client
grand_parent: Usage
nav_order: 4
---

# Character Encoding

{: .note }
Slack expects `text` to be UTF-8 encoded. If your messages appear with text such as `BAD+11` in Slack, check `text.encoding` and `.encode(Encoding::UTF_8)` your messages before sending them to Slack.

```ruby
text = 'characters such as "Ñ", "Á", "É"'
text.encoding
=> #<Encoding:UTF-8>
client.chat_postMessage(channel: '#general', text: text, as_user: true)
# renders 'characters such as "Ñ", "Á", "É"' in Slack

text = text.encode(Encoding::ISO_8859_1)
text.encoding
# => #<Encoding:ISO-8859-1>
client.chat_postMessage(channel: '#general', text: text, as_user: true)
# renders 'characters such as "BAD+11", "", "BAD+9"' in Slack
```
