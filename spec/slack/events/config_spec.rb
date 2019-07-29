# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Slack::Events::Config do
  before do
    ENV['SLACK_SIGNING_SECRET'] = 'secret'
    described_class.reset
  end

  after do
    ENV.delete 'SLACK_SIGNING_SECRET'
  end

  it 'defaults signing secret to ENV[SLACK_SIGNING_SECRET]' do
    expect(Slack::Events.config.signing_secret).to eq 'secret'
  end
  it 'defaults signature expiration to 5 minutes' do
    expect(Slack::Events.config.signature_expires_in).to eq 5 * 60
  end
  context 'configured' do
    before do
      Slack::Events.configure do |config|
        config.signing_secret = 'custom'
        config.signature_expires_in = 45
      end
    end

    it 'uses the configured values' do
      expect(Slack::Events.config.signing_secret).to eq 'custom'
      expect(Slack::Events.config.signature_expires_in).to eq 45
    end
  end
end
