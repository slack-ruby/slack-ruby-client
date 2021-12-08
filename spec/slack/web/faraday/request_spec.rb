# frozen_string_literal: true
require 'spec_helper'

class DummyClient
  include Slack::Web::Faraday::Connection
  include Slack::Web::Faraday::Request

  attr_reader :token

  def initialize(token)
    @token = token
  end
end

RSpec.describe Slack::Web::Faraday::Request do
  let(:token) { 'by-the-power-of-grayskull' }
  let(:client) { DummyClient.new(token) }

  before do
    Slack::Config.reset
  end

  context 'authorization' do
    let(:path) { '/any-path' }
    let(:options) { {} }
    let(:connection) { instance_double('Faraday::Connection') }
    let(:request) { instance_double('Faraday::Request') }
    let(:headers) { instance_double('Faraday::Utils::Headers') }
    let(:response) { instance_double('Faraday::Response', body: '') }

    before do
      allow(client).to receive(:connection).and_return(connection)
      allow(request).to receive(:url).with(path, options)
      allow(request).to receive(:path=).with(path)
      allow(request).to receive(:headers).and_return(headers)
      allow(connection).to receive(:send)
        .with(method).and_yield(request).and_return(response)
    end

    describe '#get' do
      let(:method) { :get }

      it 'sets authorization header' do
        expect(headers).to receive(:[]=)
          .with('Authorization', "Bearer #{token}")
        client.send(method, path, options)
      end
    end

    describe '#post' do
      let(:method) { :post }

      it 'sets authorization header' do
        expect(headers).to receive(:[]=)
          .with('Authorization', "Bearer #{token}")
        client.send(method, path, options)
      end
    end

    describe '#put' do
      let(:method) { :put }

      it 'sets authorization header' do
        expect(headers).to receive(:[]=)
          .with('Authorization', "Bearer #{token}")
        client.send(method, path, options)
      end
    end

    describe '#delete' do
      let(:method) { :delete }

      it 'sets authorization header' do
        expect(headers).to receive(:[]=)
          .with('Authorization', "Bearer #{token}")
        client.send(method, path, options)
      end
    end
  end
end
