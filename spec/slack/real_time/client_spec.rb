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
      context 'properties provided upon connection' do
        it 'sets url' do
          expect(client.url).to eq url
        end
        it 'sets team' do
          expect(client.team['domain']).to eq 'dblockdotorg'
        end
        it 'sets self' do
          expect(client.self['id']).to eq 'U07518DTL'
        end
        it 'sets users' do
          expect(client.users.count).to eq 7
          expect(client.users.first['id']).to eq 'U07KECJ77'
        end
        it 'sets channels' do
          expect(client.channels.count).to eq 8
          expect(client.channels.first['name']).to eq 'demo'
        end
        it 'sets ims' do
          expect(client.ims.count).to eq 2
          expect(client.ims.first['user']).to eq 'USLACKBOT'
        end
        it 'sets bots' do
          expect(client.bots.count).to eq 5
          expect(client.bots.first['name']).to eq 'bot'
        end
        it 'sets groups' do
          expect(client.groups.count).to eq 0
        end
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
      describe '#next_id' do
        it 'increments' do
          previous_id = client.send(:next_id)
          expect(client.send(:next_id)).to eq previous_id + 1
        end
      end
    end
  end
end
