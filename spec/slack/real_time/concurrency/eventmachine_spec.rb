# frozen_string_literal: true
require 'spec_helper'
require_relative './it_behaves_like_a_realtime_socket'

begin
  RSpec.describe Slack::RealTime::Concurrency::Eventmachine::Socket do
    it_behaves_like 'a realtime socket'
    context 'with url' do
      let(:url) { 'wss://ms174.slack-msgs.com/websocket/xyz' }
      let(:logger) { ::Logger.new($stdout) }
      let(:socket) { described_class.new(url, ping: 42, logger: logger) }
      let(:ws) { double(Faye::WebSocket::Client) }

      describe '#connect!' do
        before do
          allow(ws).to receive(:on).with(:close)
          allow(ws).to receive(:on).with(:message)
        end

        it 'connects' do
          allow(Faye::WebSocket::Client).to receive(:new).and_return(ws)
          socket.connect!
          expect(socket.instance_variable_get('@driver')).to eq ws
        end
        it 'pings every 30s' do
          expect(Faye::WebSocket::Client).to(
            receive(:new).with(url, nil, ping: 42, logger: logger).and_return(ws)
          )
          socket.connect!
        end
      end

      describe '#disconnect!' do
        it 'closes and nils the websocket' do
          socket.instance_variable_set('@driver', ws)
          expect(ws).to receive(:emit).with(:close)
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
rescue LoadError
end
