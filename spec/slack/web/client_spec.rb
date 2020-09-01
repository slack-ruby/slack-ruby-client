# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Slack::Web::Client do
  before do
    Slack::Config.reset
  end

  context 'with defaults' do
    let(:client) { described_class.new }

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
        context key.to_s do
          let(:client) { described_class.new(key => 'custom') }

          it "sets #{key}" do
            expect(client.send(key)).not_to eq Slack::Web::Config.send(key)
            expect(client.send(key)).to eq 'custom'
          end
        end
      end
    end
  end

  context 'global config' do
    after do
      described_class.config.reset
    end

    let(:client) { described_class.new }

    context 'user-agent' do
      before do
        described_class.configure do |config|
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
        client = described_class.new
        expect(client.token).to eq 'global default'
      end
      context 'with web config' do
        before do
          described_class.configure do |config|
            config.token = 'custom web token'
          end
        end

        it 'overrides token to web config' do
          client = described_class.new
          expect(client.token).to eq 'custom web token'
        end
        it 'overrides token to specific token' do
          client = described_class.new(token: 'local token')
          expect(client.token).to eq 'local token'
        end
      end
    end

    context 'proxy' do
      before do
        described_class.configure do |config|
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
        described_class.configure do |config|
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
        described_class.configure do |config|
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

    context 'adapter option' do
      let(:adapter) { Faraday.default_adapter }
      let(:adapter_class) { Faraday::Adapter::NetHttp }

      around do |ex|
        previous_adapter = Faraday.default_adapter
        # ensure default adapter is set for this spec
        Faraday.default_adapter = :net_http
        ex.run
        Faraday.default_adapter = previous_adapter
      end

      context 'default adapter' do
        describe '#initialize' do
          it 'sets adapter' do
            expect(client.adapter).to eq adapter
          end
          it 'creates a connection with an adapter' do
            expect(client.send(:connection).adapter).to eq adapter_class
          end
        end
      end

      context 'non default adapter' do
        let(:adapter) { :typhoeus }
        let(:adapter_class) { Faraday::Adapter::Typhoeus }

        before do
          described_class.configure do |config|
            config.adapter = adapter
          end
        end

        describe '#initialize' do
          it 'sets adapter' do
            expect(client.adapter).to eq adapter
          end
          it 'creates a connection with an adapter' do
            expect(client.send(:connection).adapter).to eq adapter_class
          end
        end
      end
    end

    context 'timeout options' do
      before do
        described_class.configure do |config|
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

        # get the yielded request to reuse in the next call to
        # rtm_start so that we can examine request.options later
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

    context 'calling undocumented methods' do
      let(:client) { described_class.new }

      it 'produces a warning' do
        expect(client.logger).to(
          receive(:warn).with('The users.admin.setInactive method is undocumented.')
        )
        expect(client).to receive(:post)
        client.users_admin_setInactive(user: 'U092BDCLV')
      end
    end

    context 'when calling deprecated methods' do
      let(:client) { described_class.new }

      it 'produces a warning' do
        expect(client.logger).to receive(:warn).with(/
          ^channels\.archive:\ This\ method\ is\ deprecated
          .+
          Alternative\ methods:\ conversations\.archive\.
        /x)

        expect(client).to receive(:post)
        client.channels_archive(channel: 'test')
      end
    end

    context 'persistent capability' do
      describe '#initialize' do
        it 'caches the Faraday connection to allow persistent adapters' do
          first = client.send(:connection)
          second = client.send(:connection)

          expect(first).to equal second
        end
      end
    end
  end
end
