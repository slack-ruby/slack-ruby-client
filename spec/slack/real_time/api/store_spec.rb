require 'spec_helper'

RSpec.describe Slack::RealTime::Client, vcr: { cassette_name: 'web/rtm_start' } do
  include_context 'connected client'

  describe '#user_change' do
    it 'updates user in store' do
      expect(client.users['U07KECJ77']['name']).to eq 'aws'
      event = Slack::RealTime::Event.new(
        'type' => 'user_change',
        'user' => {
          'id' => 'U07KECJ77', 'name' => 'renamed'
        })
      client.send(:dispatch, event)
      expect(client.users['U07KECJ77']['name']).to eq 'renamed'
    end
  end
  describe '#team_join' do
    it 'creates a user in store' do
      expect do
        event = Slack::RealTime::Event.new(
          'type' => 'team_join',
          'user' => {
            'id' => 'DEADBEEF', 'name' => 'added'
          })
        client.send(:dispatch, event)
      end.to change(client.users, :count).by(1)
      expect(client.users['DEADBEEF']['name']).to eq 'added'
    end
  end
end
