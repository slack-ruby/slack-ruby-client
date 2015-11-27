require 'spec_helper'

RSpec.describe Slack::RealTime::Client, vcr: { cassette_name: 'web/rtm_start' } do
  let(:ws) { double(Slack::RealTime::Concurrency::Mock::WebSocket, on: true) }
  let(:url) { 'wss://ms173.slack-msgs.com/websocket/lqcUiAvrKTP-uuid=' }
  before do
    Slack::RealTime.configure do |config|
      config.concurrency = Slack::RealTime::Concurrency::Mock
    end
  end
  context 'token' do
    before do
      Slack.configure do |config|
        config.token = 'global default'
      end
    end
    it 'defaults token to global default' do
      client = Slack::RealTime::Client.new
      expect(client.token).to eq 'global default'
      expect(client.web_client.token).to eq 'global default'
    end
    context 'with real time config' do
      before do
        Slack::RealTime::Client.configure do |config|
          config.token = 'custom real time token'
        end
      end
      it 'overrides token to real time config' do
        client = Slack::RealTime::Client.new
        expect(client.token).to eq 'custom real time token'
        expect(client.web_client.token).to eq 'custom real time token'
      end
      it 'overrides token to specific token' do
        client = Slack::RealTime::Client.new(token: 'local token')
        expect(client.token).to eq 'local token'
        expect(client.web_client.token).to eq 'local token'
      end
    end
  end
  context 'client' do
    let(:client) { Slack::RealTime::Client.new }
    context 'started' do
      describe '#start!' do
        let(:socket) { double(Slack::RealTime::Socket, connected?: true) }
        before do
          allow(Slack::RealTime::Socket).to receive(:new).with(url, ping: 30).and_return(socket)
          allow(socket).to receive(:connect!)
          allow(socket).to receive(:start_sync).and_yield
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
    context 'with defaults' do
      describe '#initialize' do
        it 'sets ping' do
          expect(client.websocket_ping).to eq 30
        end
        it "doesn't set proxy" do
          expect(client.websocket_proxy).to be nil
        end
        Slack::RealTime::Config::ATTRIBUTES.each do |key|
          it "sets #{key}" do
            expect(client.send(key)).to eq Slack::RealTime::Config.send(key)
          end
        end
      end
    end
  end
  context 'with custom settings' do
    describe '#initialize' do
      Slack::RealTime::Config::ATTRIBUTES.each do |key|
        context key do
          let(:client) { Slack::RealTime::Client.new(key => 'custom') }
          it "sets #{key}" do
            expect(client.send(key)).to_not eq Slack::RealTime::Config.send(key)
            expect(client.send(key)).to eq 'custom'
          end
        end
      end
    end
  end
  context 'global config' do
    after do
      Slack::RealTime::Client.config.reset
    end
    let(:client) { Slack::RealTime::Client.new }
    context 'ping' do
      before do
        Slack::RealTime::Client.configure do |config|
          config.websocket_ping = 15
        end
      end
      describe '#initialize' do
        it 'sets ping' do
          expect(client.websocket_ping).to eq 15
        end
        it 'creates a connection with custom ping' do
          expect(Slack::RealTime::Concurrency::Mock::WebSocket).to receive(:new).with(url, nil, ping: 15).and_return(ws)
          client.start!
        end
      end
    end
    context 'proxy' do
      before do
        Slack::RealTime::Client.configure do |config|
          config.websocket_proxy = {
            origin: 'http://username:password@proxy.example.com',
            headers: { 'User-Agent' => 'ruby' }
          }
        end
      end
      describe '#initialize' do
        it 'sets proxy' do
          expect(client.websocket_proxy).to eq(
            origin: 'http://username:password@proxy.example.com',
            headers: { 'User-Agent' => 'ruby' }
          )
        end
        it 'creates a connection with custom proxy' do
          expect(Slack::RealTime::Concurrency::Mock::WebSocket).to receive(:new).with(
            url,
            nil,
            ping: 30,
            proxy: {
              origin: 'http://username:password@proxy.example.com',
              headers: { 'User-Agent' => 'ruby' }
            }).and_return(ws)
          client.start!
        end
      end
    end
  end
end
