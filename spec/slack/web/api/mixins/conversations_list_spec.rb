# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Slack::Web::Client do
  context 'conversations_setTopic' do
    it 'does not invoke conversations_list', vcr: { cassette_name: 'web/conversations_setTopic' } do
      rc = subject.conversations_setTopic({ channel: 'C018Y6VH39D', topic: 'new topic' })
      expect(rc.channel.topic.value).to eq 'new topic'
    end

    it 'resolves IDs via conversations_list', vcr: { cassette_name: 'web/conversations_setTopic_one_page' } do
      rc = subject.conversations_setTopic({ channel: '#1', topic: 'new topic' })
      expect(rc.channel.topic.value).to eq 'new topic'
    end

    it 'paginates to resolve IDs', vcr: { cassette_name: 'web/conversations_setTopic_paginated' } do
      rc = subject.conversations_setTopic({ channel: '#topic', topic: 'new topic' })
      expect(rc.channel.topic.value).to eq 'new topic'
    end
  end
end
