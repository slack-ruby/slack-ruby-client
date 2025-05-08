# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Slack::Web::Api::Mixins::Conversations do
  subject(:conversations) do
    klass.new
  end

  let(:klass) do
    Class.new do
      include Slack::Web::Api::Mixins::Conversations
    end
  end

  before do
    allow(conversations).to receive(:conversations_id_page_size).and_return(100)
    allow(conversations).to receive(:conversations_list).and_yield(
      Slack::Messages::Message.new(
        'channels' => [{
          'id' => 'CDEADBEEF',
          'name' => 'general'
        }]
      )
    )
  end

  describe '#conversations_id' do
    it 'leaves channels specified by ID alone' do
      expect(conversations.conversations_id(channel: 'C123456')).to(
        eq('ok' => true, 'channel' => { 'id' => 'C123456' })
      )
    end

    it 'translates a channel that starts with a #' do
      expect(conversations.conversations_id(channel: '#general')).to(
        eq('ok' => true, 'channel' => { 'id' => 'CDEADBEEF' })
      )
    end

    it 'forwards a provided limit to the underlying conversations_list calls' do
      expect(conversations).to receive(:conversations_list).with(limit: 1234)
      conversations.conversations_id(channel: '#general', limit: 1234)
    end

    it 'fails with an exception' do
      expect { conversations.conversations_id(channel: '#invalid') }.to(
        raise_error(Slack::Web::Api::Errors::SlackError, 'channel_not_found')
      )
    end
  end
end
