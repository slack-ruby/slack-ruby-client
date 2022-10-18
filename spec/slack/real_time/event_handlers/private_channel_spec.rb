# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Slack::RealTime::Client, vcr: { cassette_name: 'web/rtm_connect' } do
  include_context 'connected client'
  include_context 'loaded client'

  context 'private channel' do
    it 'sets private channel data' do
      expect(client.private_channels.count).to eq 1
    end

    it 'group_joined' do
      expect(client.private_channels['CDEADBEEF']).to be_nil
      event = Slack::RealTime::Event.new(
        'type' => 'group_joined',
        'channel' => {
          'id' => 'CDEADBEEF',
          'name' => 'beef'
        }
      )
      client.send(:dispatch, event)
      channel = client.private_channels['CDEADBEEF']
      expect(channel).not_to be_nil
      expect(channel.name).to eq 'beef'
    end

    it 'group_left' do
      channel = client.private_channels['G0K7EV5A7']
      expect(channel.members).to include client.self.id
      event = Slack::RealTime::Event.new(
        'type' => 'group_left',
        'channel' => 'G0K7EV5A7'
      )
      client.send(:dispatch, event)
      expect(client.private_channels['G0K7EV5A7']).to be_nil
    end

    it 'group_archive' do
      channel = client.private_channels['G0K7EV5A7']
      expect(channel.is_archived).to be false
      event = Slack::RealTime::Event.new(
        'type' => 'group_archive',
        'channel' => 'G0K7EV5A7'
      )
      client.send(:dispatch, event)
      expect(channel.is_archived).to be true
    end

    it 'group_unarchive' do
      channel = client.private_channels['G0K7EV5A7']
      channel.is_archived = true
      event = Slack::RealTime::Event.new(
        'type' => 'group_unarchive',
        'channel' => 'G0K7EV5A7'
      )
      client.send(:dispatch, event)
      expect(channel.is_archived).to be false
    end

    it 'group_rename' do
      channel = client.private_channels['G0K7EV5A7']
      expect(channel.name).to eq 'mpdm-dblock--rubybot--player1-1'
      event = Slack::RealTime::Event.new(
        'type' => 'group_rename',
        'channel' => {
          'id' => 'G0K7EV5A7',
          'name' => 'updated',
          'created' => 1_360_782_804
        }
      )
      client.send(:dispatch, event)
      expect(channel.name).to eq 'updated'
    end

    it 'group_open' do
      channel = client.private_channels['G0K7EV5A7']
      expect(channel).not_to be_nil
      event = Slack::RealTime::Event.new(
        'type' => 'group_open',
        'channel' => 'G0K7EV5A7'
      )
      client.send(:dispatch, event)
      expect(channel.is_open).to be true
    end

    it 'group_close' do
      channel = client.private_channels['G0K7EV5A7']
      expect(channel).not_to be_nil
      channel.is_open = true
      event = Slack::RealTime::Event.new(
        'type' => 'group_close',
        'channel' => 'G0K7EV5A7'
      )
      client.send(:dispatch, event)
      expect(channel.is_open).to be false
    end
  end
end
