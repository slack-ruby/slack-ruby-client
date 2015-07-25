require 'spec_helper'

RSpec.describe Slack::RealTime::Client do
  let(:url) { 'wss://ms174.slack-msgs.com/websocket/xyz' }
  let(:client) { Slack::RealTime::Client.new(url) }
  let(:ws) { double(Faye::WebSocket::Client) }
  describe '#initialize' do
    it 'sets url' do
      expect(client.url).to eq url
    end
  end
  describe '#start!' do
    before do
      allow(EM).to receive(:run).and_yield
      allow(Faye::WebSocket::Client).to receive(:new).and_return(ws)
    end
    it 'starts' do
      expect(ws).to receive(:on).with(:open)
      expect(ws).to receive(:on).with(:message)
      expect(ws).to receive(:on).with(:close)
      client.start!
      expect(client.instance_variable_get('@ws')).to eq ws
    end
    it 'cannot be invoked twice' do
      allow(ws).to receive(:on)
      client.start!
      expect do
        client.start!
      end.to raise_error Slack::RealTime::Client::ClientAlreadyStartedError
    end
  end
  describe '#stop!' do
    it 'cannot be invoked without start' do
      expect do
        client.stop!
      end.to raise_error Slack::RealTime::Client::ClientNotStartedError
    end
    it 'closes and nils the websocket' do
      client.instance_variable_set('@ws', ws)
      expect(ws).to receive(:close)
      client.stop!
    end
  end
end
