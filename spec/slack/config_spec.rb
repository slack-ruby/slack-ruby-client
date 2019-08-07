# frozen_string_literal: true
require 'spec_helper'

describe Slack::Config do
  describe '#configure' do
    before do
      Slack.configure do |config|
        config.token = 'a token'
      end
    end

    it 'sets token' do
      expect(Slack.config.token).to eq 'a token'
    end
  end
end
