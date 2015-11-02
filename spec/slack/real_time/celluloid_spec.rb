require 'spec_helper'

RSpec.describe Slack::RealTime::Celluloid::Socket do
  context 'with url' do
    let(:url) { 'wss://echo.websocket.org/websocket/xyz' }
    subject(:socket) { described_class.new(url, ping: 42) }
    let(:driver) { WebSocket::Driver::Client }
    let(:ws) { double(driver) }

    describe '#initialize' do
      it 'sets url' do
        expect(socket.url).to eq url
      end
    end

    describe '#connect!' do
      before do
        allow(ws).to receive(:on).with(:close)
      end

      xit 'connects' do
        expect(socket.driver).to receive(:start)

        socket.connect!
      end

      xit 'pings every 30s' do
        expect(driver).to receive(:client).with(socket).and_return(ws)
        socket.connect!
      end
    end

    describe '#disconnect!' do
      it 'closes and nils the websocket' do
        socket.instance_variable_set('@driver', ws)
        expect(ws).to receive(:close)
        socket.disconnect!
      end
    end

    describe 'send_data' do
      let(:driver) { socket.driver }
      before do
        allow(driver).to receive(:start)
        allow(subject).to receive(:run_loop)
        socket.connect!
      end

      it 'sends data' do
        expect(driver).to receive(:text).with('data')
        subject.send_data('data')
      end
    end
  end
end
