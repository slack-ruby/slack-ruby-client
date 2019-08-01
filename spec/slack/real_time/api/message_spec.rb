# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Slack::RealTime::Client, vcr: { cassette_name: 'web/rtm_start' } do
  include_context 'connected client'

  describe '#message' do
    before do
      allow(client).to receive(:next_id).and_return(42)
    end

    it 'sends message' do
      expect(socket).to(
        receive(:send_data)
          .with({ type: 'message', id: 42, text: 'hello world', channel: 'channel' }.to_json)
      )
      client.message(text: 'hello world', channel: 'channel')
    end
  end
end
