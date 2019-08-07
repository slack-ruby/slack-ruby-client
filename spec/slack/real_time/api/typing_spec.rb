# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Slack::RealTime::Client, vcr: { cassette_name: 'web/rtm_start' } do
  include_context 'connected client'

  describe '#typing' do
    before do
      allow(client).to receive(:next_id).and_return(42)
    end

    it 'sends a typing indicator' do
      expect(socket).to(
        receive(:send_data).with({ type: 'typing', id: 42, channel: 'channel' }.to_json)
      )
      client.typing(channel: 'channel')
    end
  end
end
