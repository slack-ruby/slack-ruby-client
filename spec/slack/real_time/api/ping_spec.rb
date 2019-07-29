# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Slack::RealTime::Client, vcr: { cassette_name: 'web/rtm_start' } do
  include_context 'connected client'

  describe '#ping' do
    before do
      allow(client).to receive(:next_id).and_return(42)
    end

    it 'sends message' do
      expect(socket).to receive(:send_data).with({ type: 'ping', id: 42 }.to_json)
      client.ping
    end
  end
end
