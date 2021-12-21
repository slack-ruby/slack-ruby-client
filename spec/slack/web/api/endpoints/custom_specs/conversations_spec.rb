# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Slack::Web::Api::Endpoints::Conversations do
  let(:client) { Slack::Web::Client.new }

  context 'groups' do
    it 'info', vcr: { cassette_name: 'web/conversations_info' } do
      json = client.conversations_info(channel: '#mpdm-dblock--rubybot--player1-1')
      expect(json.channel.name).to eq 'mpdm-dblock--rubybot--player1-1'
    end
  end
end
