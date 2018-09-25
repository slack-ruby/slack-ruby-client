require 'spec_helper'
require_relative './concurrency/it_behaves_like_a_realtime_socket'

RSpec.describe Slack::RealTime::Socket do
  it_behaves_like 'a realtime socket'
  let(:url) { 'wss://ms174.slack-msgs.com/websocket/xyz' }
  let(:logger) { ::Logger.new($stdout) }
  let!(:socket) { described_class.new(url, logger: logger) }
  let(:ws) { double(Slack::RealTime::Concurrency::Mock::WebSocket) }
  let(:ping_data) { { type: 'ping', time: Time.local(2018), id: 'test_1' } }

  before do
    allow(ws).to receive(:close)
    allow(ws).to receive(:text)
    allow(ws).to receive(:on).with(:message)
    allow(socket).to receive(:connect) { socket.instance_variable_set(:@driver, ws) }
  end
  context 'when connected' do
    before do
      socket.connect!
    end
    describe '#ping' do
      it 'sends a text message over the socket.' do
        expect(ws).to receive(:text).with(/\"type\":\"ping/)
        socket.ping(ping_data)
      end
      it 'disconnects and throws an exception on subsequent unanswered pings' do
        socket.ping(ping_data)
        expect { socket.ping(ping_data) }.to raise_error Slack::RealTime::Socket::SocketNotConnectedError
      end
    end
    describe '#pong' do
      it 'removes pings sent' do
        socket.ping(ping_data)
        expect(socket.instance_variable_get(:@pending_pings)['test_1']).to be(ping_data)
        socket.pong('test_1')
        expect(socket.instance_variable_get(:@pending_pings)).to be_empty
      end
      it 'throws an exception on invalid ping_id' do
        expect { socket.pong('abc') }.to raise_error(KeyError, 'Ping id: abc is not valid')
      end
    end
  end
  context 'when disconnected' do
    describe '#send_data' do
      it 'throws an exception when not connected' do
        expect { socket.send_data('msg') }.to raise_error Slack::RealTime::Socket::SocketNotConnectedError
      end
    end
  end
end
