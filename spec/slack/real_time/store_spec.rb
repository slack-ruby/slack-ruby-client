# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Slack::RealTime::Store do
  it 'can be initialized with an empty hash' do
    store = described_class.new(Hashie::Mash.new)
    expect(store.self).to be nil
    expect(store.groups.count).to eq 0
    expect(store.team).to be nil
    expect(store.teams.count).to eq 0
  end
end
