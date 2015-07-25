require 'spec_helper'

RSpec.describe Slack::RealTime::Client, vcr: { cassette_name: 'web/rtm_start' } do
  let(:client) { Slack::RealTime::Client.new }
  let(:ws) { double(Faye::WebSocket::Client) }
  let(:url) { 'wss://ms173.slack-msgs.com/websocket/lqcUiAvrKTP-uuid=' }
  let(:socket) { double(Slack::RealTime::Socket, connected?: true) }
  context 'started' do
    describe '#start!' do
      before do
        allow(EM).to receive(:run).and_yield
        allow(Slack::RealTime::Socket).to receive(:new).with(url).and_return(socket)
        allow(socket).to receive(:connect!).and_yield(ws)
        allow(ws).to receive(:on)
        client.start!
      end
      it 'sets url' do
        expect(client.url).to eq url
      end
      it 'uses web client to fetch url' do
        expect(client.web_client).to be_a Slack::Web::Client
      end
      it 'remembers socket' do
        expect(client.instance_variable_get('@socket')).to eq socket
      end
      it 'cannot be invoked twice' do
        expect do
          client.start!
        end.to raise_error Slack::RealTime::Client::ClientAlreadyStartedError
      end
      describe '#stop!' do
        before do
          expect(socket).to receive(:disconnect!)
          client.stop!
        end
        it 'cannot be invoked twice' do
          client.instance_variable_set('@socket', nil) # caused by a :close callback
          expect do
            client.stop!
          end.to raise_error Slack::RealTime::Client::ClientNotStartedError
        end
      end
      describe '#message' do
        before do
          allow(client).to receive(:next_id).and_return(42)
        end
        it 'sends message' do
          expect(socket).to receive(:send_data).with({ type: 'message', id: 42, text: 'hello world', channel: 'channel' }.to_json)
          client.message(text: 'hello world', channel: 'channel')
        end
      end
      describe '#typing' do
        before do
          allow(client).to receive(:next_id).and_return(42)
        end
        it 'sends a typing indicator' do
          expect(socket).to receive(:send_data).with({ type: 'typing', id: 42, channel: 'channel' }.to_json)
          client.typing(channel: 'channel')
        end
      end
      describe '#next_id' do
        it 'increments' do
          previous_id = client.send(:next_id)
          expect(client.send(:next_id)).to eq previous_id + 1
        end
      end
    end
  end
end
