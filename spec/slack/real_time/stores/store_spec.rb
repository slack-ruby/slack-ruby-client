# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Slack::RealTime::Stores::Store do
  it 'can be initialized with an empty hash' do
    store = described_class.new(Hashie::Mash.new)
    expect(store.team).to be_nil
    expect(store.teams.count).to eq 0
    expect(store.self).to be_nil
    expect(store.public_channels.count).to eq 0
    expect(store.private_channels.count).to eq 0
  end

  it 'includes event handlers in subclasses' do
    subclass = Class.new(described_class)
    expect(subclass.events.key?('channel_created')).to be true
  end

  context 'with client started' do
    let(:client) { Slack::RealTime::Client.new(store_class: described_class, concurrency: Slack::RealTime::Concurrency::Mock) }

    before do
      client.store = described_class.new(Hashie::Mash.new, { caches: :all })
    end

    it 'initializes itself with data' do
      team_info = Hashie::Mash.new(team: {})
      allow(client.web_client).to receive(:team_info).and_return(team_info)
      expect(client.web_client).to receive(:team_info)
      expect(client.web_client).to receive(:users_list)
      expect(client.web_client).to receive(:conversations_list).with(types: 'public_channel,private_channel,im,mpim')
      event = Slack::RealTime::Event.new('type' => 'hello', 'start' => true)
      client.send(:dispatch, event)
    end

    context 'when configured to only cache some types' do
      before do
        client.store = described_class.new(Hashie::Mash.new, { caches: %i[users public_channels] })
      end

      it 'initializes specified caches with data' do
        expect(client.web_client).to receive(:users_list)
        expect(client.web_client).to receive(:conversations_list).with(types: 'public_channel')
        event = Slack::RealTime::Event.new('type' => 'hello', 'start' => true)
        client.send(:dispatch, event)
      end
    end
  end
end
