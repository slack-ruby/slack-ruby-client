# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Slack::RealTime::Client, vcr: { cassette_name: 'web/rtm_start' } do
  include_context 'connected client'

  it 'is not fatal' do
    event = Slack::RealTime::Event.new(
      'type' => 'pref_change',
      'name' => 'push_sound',
      'value' => 'updated.mp3'
    )
    expect(client.self).to receive(:prefs) { raise ArgumentError }
    expect { client.send(:dispatch, event) }.not_to raise_error
  end
end
