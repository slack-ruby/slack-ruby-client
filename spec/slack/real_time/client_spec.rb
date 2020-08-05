# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Slack::RealTime::Client do # rubocop:disable Metrics/BlockLength
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
      client = described_class.new
      expect(client.token).to eq 'global default'
      expect(client.web_client.token).to eq 'global default'
    end
    context 'with real time config' do
      before do
        described_class.configure do |config|
          config.token = 'custom real time token'
        end
      end

      it 'overrides token to real time config' do
        client = described_class.new
        expect(client.token).to eq 'custom real time token'
        expect(client.web_client.token).to eq 'custom real time token'
      end
      it 'overrides token to specific token' do
        client = described_class.new(token: 'local token')
        expect(client.token).to eq 'local token'
        expect(client.web_client.token).to eq 'local token'
      end
    end
  end

  context 'websocket_ping_timer' do
    context 'with defaults' do
      let(:client) { described_class.new }

      it 'defaults to websocket_ping / 2' do
        expect(client.websocket_ping_timer).to eq 15
      end
    end

    context 'with websocket_ping value changed' do
      let(:client) { described_class.new(websocket_ping: 22) }

      it 'defaults to websocket_ping / 2' do
        expect(client.websocket_ping_timer).to eq 11
      end
    end
  end

  context 'client with a full store',
          vcr: { cassette_name: 'web/rtm_start', allow_playback_repeats: true } do
    let(:client) { described_class.new(store_class: Slack::RealTime::Stores::Store) }
    let(:url) { 'wss://ms173.slack-msgs.com/websocket/lqcUiAvrKTP-uuid=' }

    describe '#start!' do
      let(:socket) { double(Slack::RealTime::Socket, connected?: true) }

      before do
        allow(Slack::RealTime::Socket).to(
          receive(:new).with(url, ping: 30, logger: Slack::Logger.default).and_return(socket)
        )
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
        it 'includes team name in to_s' do
          expect(client.to_s).to eq(
            "id=#{client.team.id}, name=#{client.team.name}, domain=#{client.team.domain}"
          )
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
          allow(socket).to receive(:disconnect!)
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

      describe '#run_handlers' do
        describe 'empty events' do
          before do
            @e = client.store.class.events
            client.store.class.events = nil
          end

          after do
            client.store.class.events = @e
          end

          it 'returns false when event is nil' do
            expect(client.send(:run_handlers, 'example', {})).to be nil
          end
        end
      end
    end

    describe '#start_async' do
      let(:socket) { double(Slack::RealTime::Socket, connected?: true) }

      before do
        allow(Slack::RealTime::Socket).to(
          receive(:new).with(url, ping: 30, logger: Slack::Logger.default).and_return(socket)
        )
        allow(socket).to receive(:connect!)
        allow(socket).to receive(:start_async)
        client.start_async
      end

      describe '#run_ping!' do
        it 'sends ping messages when the websocket connection is idle' do
          allow(socket).to receive(:time_since_last_message).and_return(30)
          expect(socket).to receive(:send_data).with('{"type":"ping","id":1}')
          client.run_ping!
        end
        it 'reconnects the websocket if it has been idle for too long' do
          allow(socket).to receive(:time_since_last_message).and_return(75)
          allow(socket).to receive(:connected?).and_return(true)
          expect(socket).to receive(:close)
          expect(socket).to receive(:restart_async)
          client.run_ping!
        end
        [
          EOFError,
          Errno::ECONNRESET,
          Errno::EPIPE,
          Faraday::ClientError,
          Slack::Web::Api::Errors::SlackError
        ].each do |err|
          context "raising #{err}" do
            it 'does not terminate the ping worker' do
              allow(socket).to receive(:time_since_last_message) { raise err }
              expect(socket).not_to receive(:send_data)
              client.run_ping!
            end
          end
        end
        context 'raising Slack::Web::Api::Errors::SlackError' do
          %w[invalid_auth account_inactive].each do |code|
            context code do
              it 'does not terminate the ping worker' do
                allow(socket).to receive(:time_since_last_message) {
                  raise Slack::Web::Api::Errors::SlackError, code
                }
                expect(socket).not_to receive(:send_data)
                expect do
                  client.run_ping!
                end.to raise_error Slack::Web::Api::Errors::SlackError, code
              end
            end
          end
        end
      end
    end

    describe 'to_s' do
      it 'defaults to class instance' do
        expect(client.to_s).to match(/^#<Slack::RealTime::Client:0x\h+>$/)
      end
    end
  end

  context 'client with starter store', vcr: { cassette_name: 'web/rtm_connect' } do
    let(:client) { described_class.new(store_class: Slack::RealTime::Stores::Starter) }
    let(:url) { 'wss://mpmulti-w5tz.slack-msgs.com/websocket/uid' }

    describe '#start!' do
      let(:socket) { double(Slack::RealTime::Socket, connected?: true) }

      before do
        allow(Slack::RealTime::Socket).to(
          receive(:new).with(url, ping: 30, logger: Slack::Logger.default).and_return(socket)
        )
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
        it 'includes team name in to_s' do
          expect(client.to_s).to eq(
            "id=#{client.team.id}, name=#{client.team.name}, domain=#{client.team.domain}"
          )
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
          allow(socket).to receive(:disconnect!)
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
    let(:client) { described_class.new(store_class: nil) }
    let(:url) { 'wss://mpmulti-w5tz.slack-msgs.com/websocket/uid' }

    it 'sets store to nil' do
      expect(client.store).to be nil
    end
    it "doesn't handle events" do
      event = Slack::RealTime::Event.new(
        'type' => 'team_rename',
        'name' => 'New Team Name Inc.'
      )
      expect(client).not_to receive(:run_handlers)
      client.send(:dispatch, event)
    end
    it 'self' do
      expect(client.self).to be nil
    end
    it 'team' do
      expect(client.team).to be nil
    end
    describe 'to_s' do
      it 'defaults to class instance' do
        expect(client.to_s).to match(/^#<Slack::RealTime::Client:0x\h+>$/)
      end
    end
  end

  context 'client with defaults' do
    let(:client) { described_class.new }

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

    describe '#run_ping?' do
      it 'returns true when websocket_ping is greater than 0' do
        client.websocket_ping = 30
        expect(client.run_ping?).to be true
      end
      it 'returns false when websocket_ping is less than 1' do
        client.websocket_ping = 0
        expect(client.run_ping?).to be false
        client.websocket_ping = nil
        expect(client.run_ping?).to be false
      end
    end
  end

  context 'with custom settings' do
    describe '#initialize' do
      Slack::RealTime::Config::ATTRIBUTES.each do |key|
        context key.to_s do
          let(:client) { described_class.new(key => 'custom') }

          it "sets #{key}" do
            expect(client.send(key)).not_to eq Slack::RealTime::Config.send(key)
            expect(client.send(key)).to eq 'custom'
          end
        end
      end
    end

    describe 'logger accessor' do
      let(:client) { described_class.new }

      it 'exposes public logger' do
        expect(client.logger).to be_a(::Logger)
      end
      it 'exposes public logger=' do
        expect { client.logger = nil }.not_to raise_error(NoMethodError)
      end
    end
  end

  context 'global config' do
    after do
      described_class.config.reset
    end

    let(:url) { 'wss://ms173.slack-msgs.com/websocket/lqcUiAvrKTP-uuid=' }
    let(:client) { described_class.new }

    context 'ping' do
      before do
        described_class.configure do |config|
          config.websocket_ping = 15
        end
      end

      describe '#initialize' do
        it 'sets ping' do
          expect(client.websocket_ping).to eq 15
        end
        it 'creates a connection with custom ping', vcr: { cassette_name: 'web/rtm_start' } do
          expect(Slack::RealTime::Concurrency::Mock::WebSocket).to(
            receive(:new).with(url, nil, ping: 15).and_return(ws)
          )
          client.start!
        end
        it 'sets start_options' do
          expect(client.start_options).to eq(request: { timeout: 180 })
        end
      end
    end

    context 'proxy' do
      before do
        described_class.configure do |config|
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
        described_class.configure do |config|
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
            expect(client.web_client).to(
              receive(:rtm_start).with(simple_latest: true).and_call_original
            )
            client.start!
          end
        end
      end
    end

    context 'store_class' do
      context 'starter' do
        before do
          described_class.configure do |config|
            config.store_class = Slack::RealTime::Stores::Starter
          end
        end

        describe '#initialize' do
          it 'can be overriden explicitly' do
            client = described_class.new(store_class: Slack::RealTime::Store)
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
          described_class.configure do |config|
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
          client = described_class.new(start_method: :overriden)
          expect(client.send(:start_method)).to eq :overriden
        end
        context 'with start_method' do
          before do
            described_class.configure do |config|
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

          it 'defaults to :rtm_start when using full store',
             vcr: { cassette_name: 'web/rtm_start' } do
            expect(client.web_client).to receive(:rtm_start).and_call_original
            client.start!
          end
        end
      end
    end
  end
end
