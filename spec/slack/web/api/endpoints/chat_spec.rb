# frozen_string_literal: true
# This file was auto-generated by lib/tasks/web.rake

require 'spec_helper'

RSpec.describe Slack::Web::Api::Endpoints::Chat do
  let(:client) { Slack::Web::Client.new }
  context 'chat_postEphemeral' do
    it 'encodes attachments, blocks as json' do
      expect(client).to receive(:post).with('chat.postEphemeral', channel: %q[], text: %q[], user: %q[], attachments: %q[{"data":["data"]}], blocks: %q[{"data":["data"]}])
      client.chat_postEphemeral(channel: %q[], text: %q[], user: %q[], attachments: {:data=>["data"]}, blocks: {:data=>["data"]})
    end
  end
  context 'chat_postMessage' do
    it 'encodes attachments, blocks, metadata as json' do
      expect(client).to receive(:post).with('chat.postMessage', channel: %q[], attachments: %q[{"data":["data"]}], blocks: %q[{"data":["data"]}], metadata: %q[{"data":["data"]}])
      client.chat_postMessage(channel: %q[], attachments: {:data=>["data"]}, blocks: {:data=>["data"]}, metadata: {:data=>["data"]})
    end
  end
  context 'chat_scheduleMessage' do
    it 'encodes attachments, blocks, metadata as json' do
      expect(client).to receive(:post).with('chat.scheduleMessage', channel: %q[], post_at: %q[], text: %q[], attachments: %q[{"data":["data"]}], blocks: %q[{"data":["data"]}], metadata: %q[{"data":["data"]}])
      client.chat_scheduleMessage(channel: %q[], post_at: %q[], text: %q[], attachments: {:data=>["data"]}, blocks: {:data=>["data"]}, metadata: {:data=>["data"]})
    end
  end
  context 'chat_unfurl' do
    it 'encodes unfurls, user_auth_blocks as json' do
      expect(client).to receive(:post).with('chat.unfurl', channel: %q[], ts: %q[], unfurls: %q[{"data":["data"]}], user_auth_blocks: %q[{"data":["data"]}])
      client.chat_unfurl(channel: %q[], ts: %q[], unfurls: {:data=>["data"]}, user_auth_blocks: {:data=>["data"]})
    end
  end
  context 'chat_update' do
    it 'encodes attachments, blocks, metadata as json' do
      expect(client).to receive(:post).with('chat.update', channel: %q[], ts: %q[], attachments: %q[{"data":["data"]}], blocks: %q[{"data":["data"]}], metadata: %q[{"data":["data"]}])
      client.chat_update(channel: %q[], ts: %q[], attachments: {:data=>["data"]}, blocks: {:data=>["data"]}, metadata: {:data=>["data"]})
    end
  end
end
