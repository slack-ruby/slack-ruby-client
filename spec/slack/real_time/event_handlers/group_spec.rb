# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Slack::RealTime::Client, vcr: { cassette_name: 'web/rtm_start' } do
  include_context 'connected client'

  context 'group' do
    it 'sets group data' do
      expect(client.groups.count).to eq 1
    end
    it 'group_joined' do
      expect(client.groups['CDEADBEEF']).to be nil
      event = Slack::RealTime::Event.new(
        'type' => 'group_joined',
        'channel' => {
          'id' => 'CDEADBEEF',
          'name' => 'beef'
        }
      )
      client.send(:dispatch, event)
      group = client.groups['CDEADBEEF']
      expect(group).not_to be nil
      expect(group.name).to eq 'beef'
    end
    it 'group_left' do
      group = client.groups['G0K7EV5A7']
      expect(group.members).to include client.self.id
      event = Slack::RealTime::Event.new(
        'type' => 'group_left',
        'channel' => 'G0K7EV5A7'
      )
      client.send(:dispatch, event)
      expect(group.members).not_to include client.self.id
    end
    it 'group_archive' do
      group = client.groups['G0K7EV5A7']
      expect(group.is_archived).to be false
      event = Slack::RealTime::Event.new(
        'type' => 'group_archive',
        'channel' => 'G0K7EV5A7'
      )
      client.send(:dispatch, event)
      expect(group.is_archived).to be true
    end
    it 'group_unarchive' do
      group = client.groups['G0K7EV5A7']
      group.is_archived = true
      event = Slack::RealTime::Event.new(
        'type' => 'group_unarchive',
        'channel' => 'G0K7EV5A7'
      )
      client.send(:dispatch, event)
      expect(group.is_archived).to be false
    end
    it 'group_rename' do
      group = client.groups['G0K7EV5A7']
      expect(group.name).to eq 'mpdm-dblock--rubybot--player1-1'
      event = Slack::RealTime::Event.new(
        'type' => 'group_rename',
        'channel' => {
          'id' => 'G0K7EV5A7',
          'name' => 'updated',
          'created' => 1_360_782_804
        }
      )
      client.send(:dispatch, event)
      expect(group.name).to eq 'updated'
    end
    it 'group_open' do
      group = client.groups['G0K7EV5A7']
      expect(group).not_to be_nil
      event = Slack::RealTime::Event.new(
        'type' => 'group_open',
        'channel' => 'G0K7EV5A7'
      )
      client.send(:dispatch, event)
      expect(group.is_open).to be true
    end
    it 'group_close' do
      group = client.groups['G0K7EV5A7']
      expect(group).not_to be_nil
      group.is_open = true
      event = Slack::RealTime::Event.new(
        'type' => 'group_close',
        'channel' => 'G0K7EV5A7'
      )
      client.send(:dispatch, event)
      expect(group.is_open).to be false
    end
  end
end
