# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Slack::RealTime::Client, vcr: { cassette_name: 'web/rtm_connect' } do
  include_context 'connected client'

  context 'im' do
    it 'im_created' do
      expect(client.ims['CDEADBEEF']).to be_nil
      event = Slack::RealTime::Event.new(
        'type' => 'im_created',
        'channel' => {
          'id' => 'CDEADBEEF',
          'name' => 'beef'
        }
      )
      client.send(:dispatch, event)
      im = client.ims['CDEADBEEF']
      expect(im).not_to be_nil
      expect(im.name).to eq 'beef'
    end

    context 'with im loaded in the store' do
      include_context 'loaded client'

      it 'im_open' do
        im = client.ims['D0J1H6QTV']
        expect(im).not_to be_nil
        im.is_open = false
        event = Slack::RealTime::Event.new(
          'type' => 'im_open',
          'channel' => 'D0J1H6QTV'
        )
        client.send(:dispatch, event)
        expect(im.is_open).to be true
      end

      it 'im_close' do
        im = client.ims['D0J1H6QTV']
        expect(im).not_to be_nil
        expect(im.is_open).to be true
        event = Slack::RealTime::Event.new(
          'type' => 'im_close',
          'channel' => 'D0J1H6QTV'
        )
        client.send(:dispatch, event)
        expect(im.is_open).to be false
      end
    end
  end
end
