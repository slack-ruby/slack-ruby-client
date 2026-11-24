# frozen_string_literal: true

require_relative 'support'

message = 'Hey <@U024BE7LH|bob>, did you see <#C1234|general>? “Quoted” ‘text’ &amp; ' \
          '<https://example.com|a link> &gt; file.txt <!everyone>'
plain = 'A message without any special formatting, which is the most common case for unescape.' * 3
markdown = "**Bold**, *italic*, ***both***, ~~struck~~, and a [link](https://example.com).\n" * 5
escape = 'Hello & <world>, 1 < 2 && 3 > 2.' * 5

SlackBenchmarks.run('Slack::Messages::Formatting') do |x|
  x.report('unescape (formatted)') { Slack::Messages::Formatting.unescape(message) }
  x.report('unescape (plain)') { Slack::Messages::Formatting.unescape(plain) }
  x.report('escape') { Slack::Messages::Formatting.escape(escape) }
  x.report('markdown (formatted)') { Slack::Messages::Formatting.markdown(markdown) }
  x.report('markdown (plain)') { Slack::Messages::Formatting.markdown(plain) }
end
