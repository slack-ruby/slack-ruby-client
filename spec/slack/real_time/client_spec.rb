require 'spec_helper'

RSpec.describe Slack::RealTime::Client do
  let(:ws) { double(Slack::RealTime::Concurrency::Mock::WebSocket, on: true) }
  before do
    @token = ENV.delete('SLACK_API_TOKEN')
    Slack::Config.reset
    Slack::RealTime::Config.reset
    Slack::RealTime.configure do |config|
      config.concurrency = Slack::RealTime::Concurrency::Mock
    end
  end
  after do
    ENV['SLACK_API_TOKEN'] = @token if @token
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
  context 'client with a full store', vcr: { cassette_name: 'web/rtm_start' } do
    let(:client) { Slack::RealTime::Client.new(store_class: Slack::RealTime::Stores::Store) }
    let(:url) { 'wss://ms173.slack-msgs.com/websocket/lqcUiAvrKTP-uuid=' }
    describe '#start!' do
      let(:socket) { double(Slack::RealTime::Socket, connected?: true) }
      before do
        allow(Slack::RealTime::Socket).to receive(:new).with(url, ping: 30, logger: Slack::Logger.default).and_return(socket)
        allow(socket).to receive(:connect!)
        allow(socket).to receive(:start_sync)
        client.start!
      end
      describe 'properties provided upon connection' do
        it 'sets url' do
          expect(client.url).to eq url
        end
        it 'sets team' do
          expect(client.team.domain).to eq 'dblockdotorg'
        end
        it 'sets teams' do
          expect(client.teams.count).to eq 1
          expect(client.teams.values.first).to eq client.team
        end
        it 'sets self' do
          expect(client.self.id).to eq 'U07518DTL'
        end
        it 'sets users' do
          expect(client.users.count).to eq 18
          expect(client.users.values.first['id']).to eq 'U07518DTL'
        end
        it 'sets channels' do
          expect(client.channels.count).to eq 37
          expect(client.channels.values.first['name']).to eq 'a1'
        end
        it 'sets ims' do
          expect(client.ims.count).to eq 2
          expect(client.ims.values.first['user']).to eq 'USLACKBOT'
        end
        it 'sets bots' do
          expect(client.bots.count).to eq 16
          expect(client.bots.values.first['name']).to eq 'bot'
        end
        it 'sets groups' do
          expect(client.groups.count).to eq 1
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
      context 'subclassed' do
        it 'runs event handlers' do
          event = Slack::RealTime::Event.new(
            'type' => 'team_rename',
            'name' => 'New Team Name Inc.'
          )
          client.send(:dispatch, event)
          expect(client.store.team.name).to eq 'New Team Name Inc.'
        end
      end
    end
  end
  context 'client with starter store', vcr: { cassette_name: 'web/rtm_connect' } do
    let(:client) { Slack::RealTime::Client.new(store_class: Slack::RealTime::Stores::Starter) }
    let(:url) { 'wss://mpmulti-w5tz.slack-msgs.com/websocket/uid' }
    describe '#start!' do
      let(:socket) { double(Slack::RealTime::Socket, connected?: true) }
      before do
        allow(Slack::RealTime::Socket).to receive(:new).with(url, ping: 30, logger: Slack::Logger.default).and_return(socket)
        allow(socket).to receive(:connect!)
        allow(socket).to receive(:start_sync)
        client.start!
      end
      describe 'properties provided upon connection' do
        it 'sets url' do
          expect(client.url).to eq url
        end
        it 'sets team' do
          expect(client.team.domain).to eq 'dblockdotorg'
        end
        it 'sets self' do
          expect(client.self.id).to eq 'U07518DTL'
        end
        it 'no users' do
          expect(client.users).to be_nil
        end
        it 'no teams' do
          expect(client.teams).to be_nil
        end
        it 'no channels' do
          expect(client.channels).to be_nil
        end
        it 'no ims' do
          expect(client.ims).to be_nil
        end
        it 'no bots' do
          expect(client.bots).to be_nil
        end
        it 'no groups' do
          expect(client.groups).to be_nil
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
  context 'client with nil store', vcr: { cassette_name: 'web/rtm_connect' } do
    let(:client) { Slack::RealTime::Client.new(store_class: nil) }
    let(:url) { 'wss://mpmulti-w5tz.slack-msgs.com/websocket/uid' }
    it 'sets store to nil' do
      expect(client.store).to be nil
    end
    it "doesn't handle events" do
      event = Slack::RealTime::Event.new(
        'type' => 'team_rename',
        'name' => 'New Team Name Inc.'
      )
      expect(client).to_not receive(:run_handlers)
      client.send(:dispatch, event)
    end
    it 'self' do
      expect(client.self).to be nil
    end
    it 'team' do
      expect(client.team).to be nil
    end
  end
  context 'client with defaults' do
    let(:client) { Slack::RealTime::Client.new }
    describe '#initialize' do
      it 'sets ping' do
        expect(client.websocket_ping).to eq 30
      end
      it "doesn't set proxy" do
        expect(client.websocket_proxy).to be nil
      end
      it 'defaults logger' do
        expect(client.send(:logger)).to be_a ::Logger
      end
      it 'sets default store_class' do
        expect(client.send(:store_class)).to eq Slack::RealTime::Store
      end
      (Slack::RealTime::Config::ATTRIBUTES - %i[logger store_class]).each do |key|
        it "sets #{key}" do
          expect(client.send(key)).to eq Slack::RealTime::Config.send(key)
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
    let(:url) { 'wss://ms173.slack-msgs.com/websocket/lqcUiAvrKTP-uuid=' }
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
        it 'creates a connection with custom ping', vcr: { cassette_name: 'web/rtm_start' } do
          expect(Slack::RealTime::Concurrency::Mock::WebSocket).to receive(:new).with(url, nil, ping: 15).and_return(ws)
          client.start!
        end
        it 'sets start_options' do
          expect(client.start_options).to eq(request: { timeout: 180 })
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
        it 'creates a connection with custom proxy', vcr: { cassette_name: 'web/rtm_start' } do
          expect(Slack::RealTime::Concurrency::Mock::WebSocket).to receive(:new).with(
            url,
            nil,
            ping: 30,
            proxy: {
              origin: 'http://username:password@proxy.example.com',
              headers: { 'User-Agent' => 'ruby' }
            }
          ).and_return(ws)
          client.start!
        end
      end
    end
    context 'start_options' do
      before do
        Slack::RealTime::Client.configure do |config|
          config.start_options = { simple_latest: true }
        end
      end
      describe '#initialize' do
        it 'sets start_options' do
          expect(client.start_options).to eq(simple_latest: true)
        end
        context 'start!' do
          let(:socket) { double(Slack::RealTime::Socket, connected?: true) }
          before do
            allow(Slack::RealTime::Socket).to receive(:new).and_return(socket)
            allow(socket).to receive(:connect!)
            allow(socket).to receive(:start_sync)
          end
          it 'calls rtm_start with start options', vcr: { cassette_name: 'web/rtm_start' } do
            expect(client.web_client).to receive(:rtm_start).with(simple_latest: true).and_call_original
            client.start!
          end
        end
      end
    end
    context 'store_class' do
      context 'starter' do
        before do
          Slack::RealTime::Client.configure do |config|
            config.store_class = Slack::RealTime::Stores::Starter
          end
        end
        describe '#initialize' do
          it 'can be overriden explicitly' do
            client = Slack::RealTime::Client.new(store_class: Slack::RealTime::Store)
            expect(client.send(:store_class)).to eq Slack::RealTime::Store
          end
          it 'sets store_class' do
            expect(client.send(:store_class)).to eq(Slack::RealTime::Stores::Starter)
          end
          context 'start!' do
            let(:socket) { double(Slack::RealTime::Socket, connected?: true) }
            before do
              allow(Slack::RealTime::Socket).to receive(:new).and_return(socket)
              allow(socket).to receive(:connect!)
              allow(socket).to receive(:start_sync)
            end
            it 'instantiates the correct store class', vcr: { cassette_name: 'web/rtm_connect' } do
              client.start!
              expect(client.store).to be_a Slack::RealTime::Stores::Starter
            end
          end
        end
      end
      context 'store' do
        before do
          Slack::RealTime::Client.configure do |config|
            config.store_class = Slack::RealTime::Stores::Store
          end
        end
        describe '#initialize' do
          context 'start!' do
            let(:socket) { double(Slack::RealTime::Socket, connected?: true) }
            before do
              allow(Slack::RealTime::Socket).to receive(:new).and_return(socket)
              allow(socket).to receive(:connect!)
              allow(socket).to receive(:start_sync)
            end
            it 'calls rtm_start and not rtm_connect', vcr: { cassette_name: 'web/rtm_start' } do
              expect(client.web_client).to receive(:rtm_start).and_call_original
              client.start!
            end
          end
        end
      end
    end
    context 'start_method' do
      describe '#initialize' do
        it 'can be overriden explicitly' do
          client = Slack::RealTime::Client.new(start_method: :overriden)
          expect(client.send(:start_method)).to eq :overriden
        end
        context 'with start_method' do
          before do
            Slack::RealTime::Client.configure do |config|
              config.start_method = :overriden
            end
          end
          it 'sets start_method' do
            expect(client.send(:start_method)).to eq :overriden
          end
          it 'calls the overriden method' do
            expect(client.web_client).to receive(:overriden).and_raise('overriden')
            expect do
              client.start!
            end.to raise_error RuntimeError, 'overriden'
          end
        end
        context 'start!' do
          let(:socket) { double(Slack::RealTime::Socket, connected?: true) }
          before do
            allow(Slack::RealTime::Socket).to receive(:new).and_return(socket)
            allow(socket).to receive(:connect!)
            allow(socket).to receive(:start_sync)
          end
          it 'defaults to :rtm_start when using full store', vcr: { cassette_name: 'web/rtm_start' } do
            expect(client.web_client).to receive(:rtm_start).and_call_original
            client.start!
          end
        end
      end
    end
  end
end
