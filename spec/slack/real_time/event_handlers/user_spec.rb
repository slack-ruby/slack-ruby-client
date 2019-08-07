# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Slack::RealTime::Client, vcr: { cassette_name: 'web/rtm_start' } do
  include_context 'connected client'

  context 'user' do
    it 'combines user and self data on rtm.start' do
      expect(client.users['U07518DTL'].name).to eq 'rubybot'
      expect(client.users['U07518DTL']['prefs']['push_sound']).to eq 'b2.mp3'
    end
    it 'user_change' do
      expect(client.users['U07KECJ77'].name).to eq 'aws'
      event = Slack::RealTime::Event.new(
        'type' => 'user_change',
        'user' => {
          'id' => 'U07KECJ77', 'name' => 'renamed'
        }
      )
      client.send(:dispatch, event)
      expect(client.users['U07KECJ77'].name).to eq 'renamed'
    end
    it 'team_join' do
      expect do
        event = Slack::RealTime::Event.new(
          'type' => 'team_join',
          'user' => {
            'id' => 'DEADBEEF', 'name' => 'added'
          }
        )
        client.send(:dispatch, event)
      end.to change(client.users, :count).by(1)
      expect(client.users['DEADBEEF'].name).to eq 'added'
    end
    it 'pref_change' do
      event = Slack::RealTime::Event.new(
        'type' => 'pref_change',
        'name' => 'push_sound',
        'value' => 'updated.mp3'
      )
      client.send(:dispatch, event)
      expect(client.self.prefs['push_sound']).to eq 'updated.mp3'
    end
    it 'presence_change' do
      expect(client.users['U07KECJ77'].presence).to eq 'away'
      event = Slack::RealTime::Event.new(
        'type' => 'presence_change',
        'user' => 'U07KECJ77',
        'presence' => 'updated'
      )
      client.send(:dispatch, event)
      expect(client.users['U07KECJ77'].presence).to eq 'updated'
    end
    it 'manual_presence_change' do
      expect(client.self['presence']).to eq 'away'
      event = Slack::RealTime::Event.new(
        'type' => 'manual_presence_change',
        'presence' => 'updated'
      )
      client.send(:dispatch, event)
      expect(client.self.presence).to eq 'updated'
    end
  end
end
