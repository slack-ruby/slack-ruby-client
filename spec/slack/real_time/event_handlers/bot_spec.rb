# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Slack::RealTime::Client, vcr: { cassette_name: 'web/rtm_start' } do
  include_context 'connected client'

  context 'bot' do
    it 'sets bot data on rtm.start' do
      expect(client.bots.count).to eq 16
    end
    it 'bot_added' do
      expect do
        event = Slack::RealTime::Event.new(
          'type' => 'bot_added',
          'bot' => {
            'id' => 'B024BE7LH',
            'name' => 'hugbot',
            'icons' => {
              'image_48' => 'https:\/\/slack.com\/path\/to\/hugbot_48.png'
            }
          }
        )
        client.send(:dispatch, event)
      end.to change(client.bots, :count).by(1)
      bot = client.bots['B024BE7LH']
      expect(bot['id']).to eq 'B024BE7LH'
      expect(bot['name']).to eq 'hugbot'
      expect(bot['icons']['image_48']).to eq 'https:\/\/slack.com\/path\/to\/hugbot_48.png'
    end
    it 'bot_changed' do
      expect do
        event = Slack::RealTime::Event.new(
          'type' => 'bot_changed',
          'bot' => {
            'id' => 'B0751JU2H',
            'name' => 'hugbot'
          }
        )
        client.send(:dispatch, event)
      end.not_to change(client.bots, :count)
      bot = client.bots['B0751JU2H']
      expect(bot['name']).to eq 'hugbot'
    end
  end
end
