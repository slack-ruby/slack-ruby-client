require 'spec_helper'

describe Slack::Messages::Formatting do
  subject do
    Slack::Messages::Formatting
  end
  context '#unescape' do
    it 'plain text' do
      expect(subject.unescape('plain text')).to eq 'plain text'
    end
    it 'decodes an HTML-encoded message' do
      expect(subject.unescape('Hello &amp; &lt;world&gt;')).to eq 'Hello & <world>'
    end
    it 'unescapes a user reference' do
      expect(subject.unescape('Hey <@U024BE7LH|bob>, did you see my file?')).to eq 'Hey @bob, did you see my file?'
    end
    it 'unescapes a user reference without a name' do
      expect(subject.unescape('<@U02BEFY4U> ^^^')).to eq '@U02BEFY4U ^^^'
    end
    it 'unescapes a URL without text' do
      expect(subject.unescape('This message contains a URL <http://foo.com/>')).to eq 'This message contains a URL http://foo.com/'
    end
    it 'unescapes a URL with text' do
      expect(subject.unescape('So does this one: <http://www.foo.com|www.foo.com>')).to eq 'So does this one: www.foo.com'
    end
    it 'removes mailto' do
      expect(subject.unescape('<mailto:bob@example.com|Bob>')).to eq 'Bob'
    end
    it 'unlinkifies references' do
      expect(subject.unescape('Hello <@U123|bob>, say hi to <!everyone> in <#C1234|general>')).to eq 'Hello @bob, say hi to @everyone in #general'
    end
    it 'can handle a lone &gt;' do
      expect(subject.unescape('Hello <@U123|bob> &gt; file.txt')).to eq 'Hello @bob > file.txt'
    end
    it 'unescapes a double smart quote' do
      expect(subject.unescape('“hello”')).to eq '"hello"'
    end
    it 'unescapes a single smart quote' do
      expect(subject.unescape('‘hello’')).to eq "'hello'"
    end
  end
end
