# frozen_string_literal: true
require 'spec_helper'

[Slack::RealTime::Stores::Store, Slack::RealTime::Stores::Starter].each do |store_class|
  cassette = store_class == Slack::RealTime::Stores::Store ? 'web/rtm_start' : 'web/rtm_connect'
  RSpec.describe store_class, vcr: { cassette_name: cassette } do
    include_context 'connected client', store_class: store_class

    context 'team' do
      it 'sets team data on rtm.start' do
        expect(client.team.name).to eq 'dblock'
        expect(client.team.domain).to eq 'dblockdotorg'
        if store_class == Slack::RealTime::Stores::Store
          expect(client.team.email_domain).to eq 'dblock.org'
          expect(client.team.prefs.invites_only_admins).to be true
          expect(client.team.plan).to eq ''
        end
      end
      it 'team_domain_change' do
        event = Slack::RealTime::Event.new(
          'type' => 'team_domain_change',
          'url' => 'https://my.slack.com',
          'domain' => 'my'
        )
        client.send(:dispatch, event)
        expect(client.team.domain).to eq 'my'
        expect(client.team['url']).to eq 'https://my.slack.com'
      end
      it 'email_domain_changed' do
        event = Slack::RealTime::Event.new(
          'type' => 'email_domain_changed',
          'email_domain' => 'example.com'
        )
        client.send(:dispatch, event)
        expect(client.team.email_domain).to eq 'example.com'
      end
      it 'team_pref_change' do
        event = Slack::RealTime::Event.new(
          'type' => 'team_pref_change',
          'name' => 'invites_only_admins',
          'value' => false
        )
        client.send(:dispatch, event)
        expect(client.team.prefs.invites_only_admins).to be false
      end
      it 'team_rename' do
        event = Slack::RealTime::Event.new(
          'type' => 'team_rename',
          'name' => 'New Team Name Inc.'
        )
        client.send(:dispatch, event)
        expect(client.team.name).to eq 'New Team Name Inc.'
      end
      it 'team_plan_change' do
        event = Slack::RealTime::Event.new(
          'type' => 'team_plan_change',
          'plan' => 'std'
        )
        client.send(:dispatch, event)
        expect(client.team.plan).to eq 'std'
      end
    end
  end
end
