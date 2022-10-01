# frozen_string_literal: true
require 'spec_helper'
require 'faraday/typhoeus'

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
      it 'applies timeout', vcr: { cassette_name: 'web/rtm_connect', allow_playback_repeats: true } do
        # reuse the same connection for the test, otherwise it creates a new one every time
        conn = client.send(:connection)
        expect(client).to receive(:connection).and_return(conn)

        # get the yielded request to reuse in the next call to
        # rtm.connect so that we can examine request.options later
        request = nil
        response = conn.post do |r|
          r.path = 'rtm.connect'
          r.headers = {
            'Accept' => ['application/json; charset=utf-8'],
            'Authorization' => ['Bearer <SLACK_API_TOKEN>']
          }
          request = r
        end

        expect(conn).to receive(:post).and_yield(request).and_return(response)

        client.rtm_connect(request: { timeout: 3 })

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

    context 'persistent capability' do
      describe '#initialize' do
        it 'caches the Faraday connection to allow persistent adapters' do
          first = client.send(:connection)
          second = client.send(:connection)

          expect(first).to equal second
        end
      end
    end

    context 'server failures' do
      subject(:request) { client.api_test }

      let(:stub_slack_request) { stub_request(:post, 'https://slack.com/api/api.test') }
      let(:exception) do
        request
      rescue Slack::Web::Api::Errors::ServerError => e
        return e
      end

      context 'parsing error' do
        context 'when the response is not JSON' do
          before do
            stub_slack_request.to_return(body: '<html></html>', headers: { 'Content-Type' => 'text/html' })
          end

          it 'raises ParsingError' do
            expect { request }.to raise_error(Slack::Web::Api::Errors::ParsingError).with_message('parsing_error')
            expect(exception.response.body).to eq('<html></html>')
            expect(exception.cause).to be_a(Faraday::ParsingError)
            expect(exception.cause.cause).to be_a(JSON::ParserError)
          end
        end

        context 'when the response is malformed JSON' do
          before { stub_slack_request.to_return(body: '{') }

          it 'raises ParsingError' do
            expect { request }.to raise_error(Slack::Web::Api::Errors::ParsingError).with_message('parsing_error')
            expect(exception.response.body).to eq('{')
            expect(exception.cause).to be_a(Faraday::ParsingError)
            expect(exception.cause.cause).to be_a(JSON::ParserError)
          end
        end
      end

      context 'timeout' do
        context 'open timeout' do
          before { stub_slack_request.to_timeout }

          it 'raises TimoutError' do
            expect { request }.to raise_error(Slack::Web::Api::Errors::TimeoutError).with_message('timeout_error')
            expect(exception.cause).to be_a(Faraday::ConnectionFailed)
            expect(exception.cause.cause).to be_a(Net::OpenTimeout)
          end
        end

        context 'read timeout' do
          before { stub_slack_request.to_raise(Net::ReadTimeout) }

          it 'raises TimeoutError' do
            expect { request }.to raise_error(Slack::Web::Api::Errors::TimeoutError).with_message('timeout_error')
            expect(exception.cause).to be_a(Faraday::TimeoutError)
            expect(exception.cause.cause).to be_a(Net::ReadTimeout)
          end
        end
      end

      context '5xx response' do
        context 'with a JSON body' do
          before { stub_slack_request.to_return(status: 500, body: '{}') }

          it 'raises UnavailableError' do
            expect { request }.to raise_error(Slack::Web::Api::Errors::UnavailableError).with_message('unavailable_error')
            expect(exception.response.status).to eq(500)
          end
        end

        context 'with a HTML response' do
          before do
            stub_slack_request.to_return(status: 500, body: '<html></html>', headers: { 'Content-Type' => 'text/html' })
          end

          it 'raises UnavailableError' do
            expect { request }.to raise_error(Slack::Web::Api::Errors::UnavailableError).with_message('unavailable_error')
            expect(exception.response.status).to eq(500)
          end
        end
      end
    end
  end
end
