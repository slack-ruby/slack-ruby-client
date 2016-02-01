require 'spec_helper'

RSpec.describe Slack::Web::Api::Endpoints::Channels do
  let(:client) { Slack::Web::Client.new }
  context 'channels' do
    it 'info', vcr: { cassette_name: 'web/channels_info' } do
      json = client.channels_info(channel: '#general')
      expect(json.channel.name).to eq 'general'
    end
  end
end
