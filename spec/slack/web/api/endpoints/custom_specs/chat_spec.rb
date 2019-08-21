# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Slack::Web::Api::Endpoints::Chat do
  let(:client) { Slack::Web::Client.new }

  context 'chat_postEphemeral' do
    let(:user) { OpenStruct.new(user: { id: '123' }) }

    before do
      allow(described_class).to receive(:users_id).and_return(user)
    end

    it 'automatically converts attachments and blocks into JSON' do
      expect(client).to receive(:post).with(
        'chat.postEphemeral',
        channel: 'channel',
        text: 'text',
        user: '123',
        attachments: '[]',
        blocks: '[]'
      )
      client.chat_postEphemeral(
        channel: 'channel',
        text: 'text',
        user: '123',
        attachments: [],
        blocks: []
      )
    end
    context 'text and user arguments' do
      it 'requires text or attachments' do
        expect { client.chat_postEphemeral(channel: 'channel') }.to(
          raise_error(ArgumentError, /Required arguments :text, :attachments or :blocks missing/)
        )
      end
      it 'requires user' do
        expect { client.chat_postEphemeral(channel: 'channel', text: 'text') }.to(
          raise_error(ArgumentError, /Required arguments :user missing/)
        )
      end
      it 'both text and user' do
        expect(client).to(
          receive(:post).with('chat.postEphemeral', hash_including(text: 'text', user: '123'))
        )
        expect do
          client.chat_postEphemeral(channel: 'channel', text: 'text', user: '123')
        end.not_to raise_error
      end
    end

    context 'attachments argument' do
      it 'optional attachments' do
        expect(client).to(
          receive(:post).with('chat.postEphemeral', hash_including(attachments: '[]'))
        )
        expect do
          client.chat_postEphemeral(channel: 'channel', text: 'text', user: '123', attachments: [])
        end.not_to raise_error
      end
      it 'attachments without text' do
        expect(client).to(
          receive(:post).with('chat.postEphemeral', hash_including(attachments: '[]'))
        )
        expect do
          client.chat_postEphemeral(channel: 'channel', attachments: [], user: '123')
        end.not_to raise_error
      end
    end

    context 'blocks argument' do
      it 'optional blocks' do
        expect(client).to receive(:post).with('chat.postEphemeral', hash_including(blocks: '[]'))
        expect do
          client.chat_postEphemeral(channel: 'channel', text: 'text', user: '123', blocks: [])
        end.not_to raise_error
      end
      it 'blocks without text' do
        expect(client).to receive(:post).with('chat.postEphemeral', hash_including(blocks: '[]'))
        expect do
          client.chat_postEphemeral(channel: 'channel', blocks: [], user: '123')
        end.not_to raise_error
      end
    end
  end

  context 'chat_postMessage' do
    it 'automatically converts attachments and blocks into JSON' do
      expect(client).to receive(:post).with(
        'chat.postMessage',
        channel: 'channel',
        text: 'text',
        attachments: '[]',
        blocks: '[]'
      )
      client.chat_postMessage(channel: 'channel', text: 'text', attachments: [], blocks: [])
    end
    context 'text, attachment and blocks arguments' do
      it 'requires text, attachments or blocks' do
        expect { client.chat_postMessage(channel: 'channel') }.to(
          raise_error(ArgumentError, /Required arguments :text, :attachments or :blocks missing/)
        )
      end
      it 'only text' do
        expect(client).to receive(:post).with('chat.postMessage', hash_including(text: 'text'))
        expect { client.chat_postMessage(channel: 'channel', text: 'text') }.not_to raise_error
      end
      it 'only attachments' do
        expect(client).to receive(:post).with('chat.postMessage', hash_including(attachments: '[]'))
        expect { client.chat_postMessage(channel: 'channel', attachments: []) }.not_to raise_error
      end
      it 'only blocks' do
        expect(client).to receive(:post).with('chat.postMessage', hash_including(blocks: '[]'))
        expect { client.chat_postMessage(channel: 'channel', blocks: []) }.not_to raise_error
      end
      it 'all text, attachments and blocks' do
        expect(client).to(
          receive(:post)
            .with('chat.postMessage', hash_including(text: 'text', attachments: '[]', blocks: '[]'))
        )
        expect do
          client.chat_postMessage(channel: 'channel', text: 'text', attachments: [], blocks: [])
        end.not_to raise_error
      end
    end
  end

  context 'chat_update' do
    let(:ts) { '1405894322.002768' }

    it 'automatically converts attachments and blocks into JSON' do
      expect(client).to receive(:post).with(
        'chat.update',
        channel: 'channel',
        text: 'text',
        ts: ts,
        attachments: '[]',
        blocks: '[]'
      )
      client.chat_update(channel: 'channel', text: 'text', ts: ts, attachments: [], blocks: [])
    end
    context 'ts arguments' do
      it 'requires ts' do
        expect do
          client.chat_update(channel: 'channel', text: 'text')
        end.to raise_error(ArgumentError, /Required arguments :ts missing>/)
      end
    end

    context 'text, attachment and blocks arguments' do
      it 'requires text, attachments or blocks' do
        expect { client.chat_update(channel: 'channel', ts: ts) }.to(
          raise_error(ArgumentError, /Required arguments :text, :attachments or :blocks missing/)
        )
      end
      it 'only text' do
        expect(client).to receive(:post).with('chat.update', hash_including(text: 'text'))
        expect do
          client.chat_update(channel: 'channel', text: 'text', ts: ts)
        end.not_to raise_error
      end
      it 'only attachments' do
        expect(client).to receive(:post).with('chat.update', hash_including(attachments: '[]'))
        expect do
          client.chat_update(channel: 'channel', ts: ts, attachments: [])
        end.not_to raise_error
      end
      it 'only blocks' do
        expect(client).to receive(:post).with('chat.update', hash_including(blocks: '[]'))
        expect do
          client.chat_update(channel: 'channel', ts: ts, blocks: [])
        end.not_to raise_error
      end
      it 'all text, attachments and blocks' do
        expect(client).to(
          receive(:post)
            .with('chat.update', hash_including(text: 'text', attachments: '[]', blocks: '[]'))
        )
        expect do
          client.chat_update(channel: 'channel', text: 'text', ts: ts, attachments: [], blocks: [])
        end.not_to raise_error
      end
    end
  end
end
