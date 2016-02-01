require 'spec_helper'

RSpec.describe Slack::RealTime::Client, vcr: { cassette_name: 'web/rtm_start' } do
  include_context 'connected client'

  context 'team' do
    it 'sets team data on rtm.start' do
      expect(client.team['name']).to eq 'dblock'
      expect(client.team['domain']).to eq 'dblockdotorg'
      expect(client.team['email_domain']).to eq 'dblock.org'
      expect(client.team['prefs']['invites_only_admins']).to be true
      expect(client.team['plan']).to eq ''
    end
    describe 'team_domain_change' do
      it 'updates team in store' do
        event = Slack::RealTime::Event.new(
          'type' => 'team_domain_change',
          'url' => 'https://my.slack.com',
          'domain' => 'my'
        )
        client.send(:dispatch, event)
        expect(client.team['domain']).to eq 'my'
        expect(client.team['url']).to eq 'https://my.slack.com'
      end
    end
    describe 'email_domain_changed' do
      it 'updates team in store' do
        event = Slack::RealTime::Event.new(
          'type' => 'email_domain_changed',
          'email_domain' => 'example.com'
        )
        client.send(:dispatch, event)
        expect(client.team['email_domain']).to eq 'example.com'
      end
    end
    describe 'team_pref_change' do
      it 'updates team in store' do
        event = Slack::RealTime::Event.new(
          'type' => 'team_pref_change',
          'name' => 'invites_only_admins',
          'value' => false
        )
        client.send(:dispatch, event)
        expect(client.team['prefs']['invites_only_admins']).to be false
      end
    end
    describe 'team_rename' do
      it 'updates team in store' do
        event = Slack::RealTime::Event.new(
          'type' => 'team_rename',
          'name' => 'New Team Name Inc.'
        )
        client.send(:dispatch, event)
        expect(client.team['name']).to eq 'New Team Name Inc.'
      end
    end
    describe 'team_plan_change' do
      it 'updates team in store' do
        event = Slack::RealTime::Event.new(
          'type' => 'team_plan_change',
          'plan' => 'std'
        )
        client.send(:dispatch, event)
        expect(client.team['plan']).to eq 'std'
      end
    end
  end
end
