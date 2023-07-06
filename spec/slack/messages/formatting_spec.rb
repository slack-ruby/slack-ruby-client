# frozen_string_literal: true
require 'spec_helper'

describe Slack::Messages::Formatting do
  subject(:formatting) do
    described_class
  end

  context '#unescape' do
    it 'plain text' do
      expect(formatting.unescape('plain text')).to eq 'plain text'
    end

    it 'decodes an HTML-encoded message' do
      expect(formatting.unescape('Hello &amp; &lt;world&gt;')).to eq 'Hello & <world>'
    end

    it 'unescapes a user reference' do
      expect(formatting.unescape('Hey <@U024BE7LH|bob>, did you see my file?')).to(
        eq('Hey @bob, did you see my file?')
      )
    end

    it 'unescapes a user reference without a name' do
      expect(formatting.unescape('<@U02BEFY4U> ^^^')).to eq '@U02BEFY4U ^^^'
    end

    it 'unescapes a URL without text' do
      expect(formatting.unescape('This message contains a URL <http://foo.com/>')).to(
        eq('This message contains a URL http://foo.com/')
      )
    end

    it 'unescapes a URL with text' do
      expect(formatting.unescape('So does this one: <http://www.foo.com|www.foo.com>')).to(
        eq('So does this one: www.foo.com')
      )
    end

    it 'removes mailto' do
      expect(formatting.unescape('<mailto:bob@example.com|Bob>')).to eq 'Bob'
    end

    it 'unlinkifies references' do
      expect(
        formatting.unescape('Hello <@U123|bob>, say hi to <!everyone> in <#C1234|general>')
      ).to(
        eq('Hello @bob, say hi to @everyone in #general')
      )
    end

    it 'can handle a lone &gt;' do
      expect(formatting.unescape('Hello <@U123|bob> &gt; file.txt')).to eq 'Hello @bob > file.txt'
    end

    it 'unescapes a double smart quote' do
      expect(formatting.unescape('“hello”')).to eq '"hello"'
    end

    it 'unescapes a single smart quote' do
      expect(formatting.unescape('‘hello’')).to eq "'hello'"
    end
  end

  context '#escape' do
    it 'plain text' do
      expect(formatting.escape('plain text')).to eq 'plain text'
    end

    it 'escapes a message' do
      expect(formatting.escape('Hello & <world>')).to eq 'Hello &amp; &lt;world&gt;'
    end
  end

  context '#date' do
    let(:timestamp) { -2955646679 }
    let(:time) { Time.at(timestamp) }
    let(:custom_format) { '{date_short}' }
    let(:optional_link) { 'https://www.timeanddate.com/worldclock/fixedtime.html?year=1876&month=5&day=4&hour=03&min=02&sec=01' }
    let(:fallback_text) { 'a long, long time ago' }

    it 'formats a timestamp' do
      expect(formatting.date(time)).to eq "<!date^#{timestamp}^{date_num} {time_secs}|#{time}>"
    end

    it 'can use custom format' do
      expect(formatting.date(time, format: custom_format)).to eq "<!date^#{timestamp}^#{custom_format}|#{time}>"
    end

    it 'can add a custom link' do
      expect(formatting.date(time,
                             link: optional_link)).to eq "<!date^#{timestamp}^{date_num} {time_secs}^#{optional_link}|#{time}>"
    end

    it 'can add custom fallback text' do
      expect(formatting.date(time, text: fallback_text)).to eq "<!date^#{timestamp}^{date_num} {time_secs}|#{fallback_text}>"
    end
  end

  context '#channel_link' do
    let(:channel_id) { 'C0000000001' }

    it 'links to a channel by its ID' do
      expect(formatting.channel_link(channel_id)).to eq "<##{channel_id}>"
    end
  end

  context '#user_link' do
    let(:user_id) { 'U0000000001' }

    it 'links to a user by its ID' do
      expect(formatting.user_link(user_id)).to eq "<@#{user_id}>"
    end
  end

  context '#url_link' do
    let(:text) { 'super cool website' }
    let(:url) { 'https://theuselessweb.site/' }

    it 'formats a URL with custom link text' do
      expect(formatting.url_link(text, url)).to eq "<#{url}|#{text}>"
    end
  end
end
