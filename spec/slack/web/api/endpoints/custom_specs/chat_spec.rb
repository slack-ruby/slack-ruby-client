require 'spec_helper'

RSpec.describe Slack::Web::Api::Endpoints::Chat do
  let(:client) { Slack::Web::Client.new }
  context 'chat_postEphemeral' do
    let(:user) { OpenStruct.new(user: { id: '123' }) }
    before(:each) do
      allow(described_class).to receive(:users_id).and_return(user)
    end

    it 'automatically converts attachments into JSON' do
      expect(client).to receive(:post).with(
        'chat.postEphemeral',
        channel: 'channel',
        text: 'text',
        user: '123',
        attachments: '[]'
      )
      client.chat_postEphemeral(channel: 'channel', text: 'text', user: '123', attachments: [])
    end
    it 'automatically converts blocks into JSON' do
      expect(client).to receive(:post).with(
        'chat.postEphemeral',
        channel: 'channel',
        text: 'text',
        user: '123',
        blocks: '[]'
      )
      client.chat_postEphemeral(channel: 'channel', text: 'text', user: '123', blocks: [])
    end

    context 'text and user arguments' do
      it 'requires text or attachments or blocks' do
        expect { client.chat_postEphemeral(channel: 'channel') }.to raise_error ArgumentError, /Required arguments :text or :attachments or :blocks missing/
      end
      it 'requires user' do
        expect { client.chat_postEphemeral(channel: 'channel', text: 'text') }.to raise_error ArgumentError, /Required arguments :user missing/
      end
      it 'both text and user' do
        expect(client).to receive(:post).with('chat.postEphemeral', hash_including(text: 'text', user: '123'))
        expect { client.chat_postEphemeral(channel: 'channel', text: 'text', user: '123') }.to_not raise_error
      end
    end
    context 'attachments argument' do
      it 'optional attachments' do
        expect(client).to receive(:post).with('chat.postEphemeral', hash_including(attachments: '[]'))
        expect { client.chat_postEphemeral(channel: 'channel', text: 'text', user: '123', attachments: []) }.to_not raise_error
      end
      it 'attachments without text' do
        expect(client).to receive(:post).with('chat.postEphemeral', hash_including(attachments: '[]'))
        expect { client.chat_postEphemeral(channel: 'channel', attachments: [], user: '123') }.to_not raise_error
      end
    end
    context 'blocks argument' do
      it 'optional blocks' do
        expect(client).to receive(:post).with('chat.postEphemeral', hash_including(blocks: '[]'))
        expect { client.chat_postEphemeral(channel: 'channel', text: 'text', user: '123', blocks: []) }.to_not raise_error
      end
      it 'blocks without text' do
        expect(client).to receive(:post).with('chat.postEphemeral', hash_including(blocks: '[]'))
        expect { client.chat_postEphemeral(channel: 'channel', blocks: [], user: '123') }.to_not raise_error
      end
    end
  end

  context 'chat_postMessage' do
    it 'automatically converts attachments into JSON' do
      expect(client).to receive(:post).with(
        'chat.postMessage',
        channel: 'channel',
        text: 'text',
        attachments: '[]'
      )
      client.chat_postMessage(channel: 'channel', text: 'text', attachments: [])
    end
    it 'automatically converts blocks into JSON' do
      expect(client).to receive(:post).with(
        'chat.postMessage',
        channel: 'channel',
        text: 'text',
        blocks: '[]'
      )
      client.chat_postMessage(channel: 'channel', text: 'text', blocks: [])
    end
    context 'text, attachment, and blocks arguments' do
      it 'requires text or attachments or blocks' do
        expect { client.chat_postMessage(channel: 'channel') }.to raise_error ArgumentError, /Required arguments :text or :attachments or :blocks missing/
      end
      it 'only text' do
        expect(client).to receive(:post).with('chat.postMessage', hash_including(text: 'text'))
        expect { client.chat_postMessage(channel: 'channel', text: 'text') }.to_not raise_error
      end
      it 'only attachments' do
        expect(client).to receive(:post).with('chat.postMessage', hash_including(attachments: '[]'))
        expect { client.chat_postMessage(channel: 'channel', attachments: []) }.to_not raise_error
      end
      it 'both text and attachments' do
        expect(client).to receive(:post).with('chat.postMessage', hash_including(text: 'text', attachments: '[]'))
        expect { client.chat_postMessage(channel: 'channel', text: 'text', attachments: []) }.to_not raise_error
      end
      it 'only blocks' do
        expect(client).to receive(:post).with('chat.postMessage', hash_including(blocks: '[]'))
        expect { client.chat_postMessage(channel: 'channel', blocks: []) }.to_not raise_error
      end
    end
  end

  context 'chat_update' do
    let(:ts) { '1405894322.002768' }
    it 'automatically converts attachments into JSON' do
      expect(client).to receive(:post).with(
        'chat.update',
        attachments: '[]',
        channel: 'channel',
        text: 'text',
        ts: ts
      )
      client.chat_update(attachments: [], channel: 'channel', text: 'text', ts: ts)
    end
    it 'automatically converts blocks into JSON' do
      expect(client).to receive(:post).with(
        'chat.update',
        blocks: '[]',
        channel: 'channel',
        text: 'text',
        ts: ts
      )
      client.chat_update(blocks: [], channel: 'channel', text: 'text', ts: ts)
    end
    context 'ts arguments' do
      it 'requires ts' do
        expect { client.chat_update(channel: 'channel', text: 'text') }.to raise_error ArgumentError, /Required arguments :ts missing>/
      end
    end
    context 'text, attachment, and blocks arguments' do
      it 'requires text or attachments' do
        expect { client.chat_update(channel: 'channel', ts: ts) }.to raise_error ArgumentError, /Required arguments :text or :attachments or :blocks missing/
      end
      it 'only text' do
        expect(client).to receive(:post).with('chat.update', hash_including(text: 'text'))
        expect { client.chat_update(channel: 'channel', text: 'text', ts: ts) }.to_not raise_error
      end
      it 'only attachments' do
        expect(client).to receive(:post).with('chat.update', hash_including(attachments: '[]'))
        expect { client.chat_update(attachments: [], channel: 'channel', ts: ts) }.to_not raise_error
      end
      it 'both text and attachments' do
        expect(client).to receive(:post).with('chat.update', hash_including(text: 'text', attachments: '[]'))
        expect { client.chat_update(attachments: [], channel: 'channel', text: 'text', ts: ts) }.to_not raise_error
      end
      it 'only blocks' do
        expect(client).to receive(:post).with('chat.update', hash_including(blocks: '[]'))
        expect { client.chat_update(channel: 'channel', blocks: [], ts: ts) }.to_not raise_error
      end
    end
  end
end
