require 'spec_helper'

RSpec.describe Slack::RealTime::Socket do
  context 'with url' do
    let(:url) { 'wss://ms174.slack-msgs.com/websocket/xyz' }
    let(:socket) { Slack::RealTime::Socket.new(url) }
    let(:ws) { double(Faye::WebSocket::Client) }
    describe '#initialize' do
      it 'sets url' do
        expect(socket.url).to eq url
      end
    end
    describe '#connect!' do
      before do
        allow(ws).to receive(:on).with(:close)
      end
      it 'connects' do
        allow(Faye::WebSocket::Client).to receive(:new).and_return(ws)
        socket.connect!
        expect(socket.instance_variable_get('@ws')).to eq ws
      end
      it 'pings every 30s' do
        expect(Faye::WebSocket::Client).to receive(:new).with(url, nil, ping: 30).and_return(ws)
        socket.connect!
      end
    end
    describe '#disconnect!' do
      it 'closes and nils the websocket' do
        socket.instance_variable_set('@ws', ws)
        expect(ws).to receive(:close)
        socket.disconnect!
      end
    end
    describe 'send_data' do
      before do
        allow(Faye::WebSocket::Client).to receive(:new).and_return(ws)
        allow(ws).to receive(:on)
        socket.connect!
      end
      it 'sends data' do
        expect(ws).to receive(:send).with('data')
        socket.send_data('data')
      end
    end
  end
end
