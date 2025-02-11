# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Slack::Web::Api::Endpoints::Conversations do
  let(:client) { Slack::Web::Client.new }

  context 'groups' do
    it 'info', vcr: { cassette_name: 'web/conversations_info' } do
      json = client.conversations_info(channel: '#mpdm-dblock--rubybot--player1-1')
      expect(json.channel.name).to eq 'mpdm-dblock--rubybot--player1-1'
    end
  end

  context 'list' do
    it 'resolves channel and includes all arguments into http requests' do
      expect(client).to receive(:conversations_list).and_yield(
        Slack::Messages::Message.new(
          'channels' => [{
            'id' => 'CDEADBEEF',
            'name' => 'general'
          }]
        )
      )
      expect(client).to receive(:post).with('conversations.history', { channel: 'CDEADBEEF', limit: 10 })
      client.conversations_history(channel: '#general', limit: 10)
    end
  end
end
