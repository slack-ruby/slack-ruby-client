require 'spec_helper'

RSpec.describe Slack::Web::Client do
  before do
    Slack::Config.reset
  end
  context 'with defaults' do
    let(:client) { Slack::Web::Client.new }
    describe '#initialize' do
      it 'sets user-agent' do
        expect(client.user_agent).to eq Slack::Web::Config.user_agent
        expect(client.user_agent).to include Slack::VERSION
      end
      (Slack::Web::Config::ATTRIBUTES - [:logger]).each do |key|
        it "sets #{key}" do
          expect(client.send(key)).to eq Slack::Web::Config.send(key)
        end
      end
    end
  end
  context 'with custom settings' do
    describe '#initialize' do
      Slack::Web::Config::ATTRIBUTES.each do |key|
        context key do
          let(:client) { Slack::Web::Client.new(key => 'custom') }
          it "sets #{key}" do
            expect(client.send(key)).to_not eq Slack::Web::Config.send(key)
            expect(client.send(key)).to eq 'custom'
          end
        end
      end
    end
  end
  context 'global config' do
    after do
      Slack::Web::Client.config.reset
    end
    let(:client) { Slack::Web::Client.new }
    context 'user-agent' do
      before do
        Slack::Web::Client.configure do |config|
          config.user_agent = 'custom/user-agent'
        end
      end
      describe '#initialize' do
        it 'sets user-agent' do
          expect(client.user_agent).to eq 'custom/user-agent'
        end
        it 'creates a connection with the custom user-agent' do
          expect(client.send(:connection).headers).to eq(
            'Accept' => 'application/json; charset=utf-8',
            'User-Agent' => 'custom/user-agent'
          )
        end
      end
    end
    context 'token' do
      before do
        Slack.configure do |config|
          config.token = 'global default'
        end
      end
      it 'defaults token to global default' do
        client = Slack::Web::Client.new
        expect(client.token).to eq 'global default'
      end
      context 'with web config' do
        before do
          Slack::Web::Client.configure do |config|
            config.token = 'custom web token'
          end
        end
        it 'overrides token to web config' do
          client = Slack::Web::Client.new
          expect(client.token).to eq 'custom web token'
        end
        it 'overrides token to specific token' do
          client = Slack::Web::Client.new(token: 'local token')
          expect(client.token).to eq 'local token'
        end
      end
    end
    context 'proxy' do
      before do
        Slack::Web::Client.configure do |config|
          config.proxy = 'http://localhost:8080'
        end
      end
      describe '#initialize' do
        it 'sets proxy' do
          expect(client.proxy).to eq 'http://localhost:8080'
        end
        it 'creates a connection with the proxy' do
          expect(client.send(:connection).proxy.uri.to_s).to eq 'http://localhost:8080'
        end
      end
    end
    context 'SSL options' do
      before do
        Slack::Web::Client.configure do |config|
          config.ca_path = '/ca_path'
          config.ca_file = '/ca_file'
        end
      end
      describe '#initialize' do
        it 'sets ca_path and ca_file' do
          expect(client.ca_path).to eq '/ca_path'
          expect(client.ca_file).to eq '/ca_file'
        end
        it 'creates a connection with ssl options' do
          ssl = client.send(:connection).ssl
          expect(ssl.ca_path).to eq '/ca_path'
          expect(ssl.ca_file).to eq '/ca_file'
        end
      end
    end
    context 'logger option' do
      let(:logger) { Logger.new(STDOUT) }
      before do
        Slack::Web::Client.configure do |config|
          config.logger = logger
        end
      end
      describe '#initialize' do
        it 'sets logger' do
          expect(client.logger).to eq logger
        end
        it 'creates a connection with a logger' do
          expect(client.send(:connection).builder.handlers).to include ::Faraday::Response::Logger
        end
      end
    end
    context 'timeout options' do
      before do
        Slack::Web::Client.configure do |config|
          config.timeout = 10
          config.open_timeout = 15
        end
      end
      describe '#initialize' do
        it 'sets timeout and open_timeout' do
          expect(client.timeout).to eq 10
          expect(client.open_timeout).to eq 15
        end
        it 'creates a connection with timeout options' do
          conn = client.send(:connection)
          expect(conn.options.timeout).to eq 10
          expect(conn.options.open_timeout).to eq 15
        end
      end
    end
    context 'per-request options' do
      it 'applies timeout', vcr: { cassette_name: 'web/rtm_start', allow_playback_repeats: true } do
        # reuse the same connection for the test, otherwise it creates a new one every time
        conn = client.send(:connection)
        expect(client).to receive(:connection).and_return(conn)

        # get the yielded request to reuse in the next call to rtm_start so that we can examine request.options later
        request = nil
        response = conn.post do |r|
          r.path = 'rtm.start'
          r.body = { token: 'token' }
          request = r
        end

        expect(conn).to receive(:post).and_yield(request).and_return(response)

        client.rtm_start(request: { timeout: 3 })

        expect(request.options.timeout).to eq 3
      end
    end
  end
end
