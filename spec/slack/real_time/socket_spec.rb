require 'spec_helper'
require_relative './concurrency/it_behaves_like_a_realtime_socket'

RSpec.describe Slack::RealTime::Socket do
  it_behaves_like 'a realtime socket'
  let(:url) { 'wss://ms174.slack-msgs.com/websocket/xyz' }
  let(:logger) { ::Logger.new($stdout) }
  let!(:socket) { described_class.new(url, logger: logger) }
  let(:ws) { double(Slack::RealTime::Concurrency::Mock::WebSocket) }

  before do
    allow(ws).to receive(:close)
    allow(ws).to receive(:text)
    allow(ws).to receive(:on).with(:message)
    allow(socket).to receive(:connect) do
      socket.instance_variable_set(:@driver, ws)
      socket.instance_variable_set(:@alive, true)
    end
  end
  context 'when connected' do
    before do
      socket.connect!
    end
    describe '#ping' do
      it 'sends a text message over the socket.' do
        expect(ws).to receive(:text).with(/\"type\":\"ping\",\"id\":0/)
        socket.send(:ping, 0.01)
      end
      it 'disconnects subsequent unanswered pings' do
        expect(socket.connected?).to be true
        socket.send(:ping, 0.01)
        expect(socket.connected?).to be false
      end
    end
  end
end
