require 'spec_helper'

RSpec.describe Slack::Web::Api::Endpoints::Chat do
  let(:client) { Slack::Web::Client.new }
  context 'chat_postMessage' do
    it 'automatically converts attachments into JSON' do
      expect(client).to receive(:post).with(
        'chat.postMessage',
        channel: 'channel',
        text: 'text',
        attachments: [].to_json
      )
      client.chat_postMessage(channel: 'channel', text: 'text', attachments: [])
    end
  end
end
