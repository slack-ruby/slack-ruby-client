require 'spec_helper'
require_relative './it_behaves_like_a_realtime_socket'

begin
  RSpec.describe Slack::RealTime::Concurrency::Celluloid::Socket do
    it_behaves_like 'a realtime socket'
    context 'with url' do
      let(:url) { 'wss://echo.websocket.org/websocket/xyz' }
      let(:logger) { ::Logger.new(STDOUT) }

      [EOFError, Errno::EPIPE].each do |err|
        context "finishing run_loop with #{err}" do
          let(:test_socket) do
            Class.new(described_class) do
              def read
                fail options[:err]
              end
            end
          end

          let(:socket) do
            test_socket.new(url, ping: 42, logger: logger, err: err)
          end

          let(:driver) { WebSocket::Driver::Client }
          let(:ws) { double(driver) }
          subject { socket }

          describe '#connect!' do
            pending 'connects'
            pending 'pings every 30s'
          end

          context 'with a driver' do
            before do
              socket.instance_variable_set('@driver', ws)
            end

            describe '#disconnect!' do
              it 'closes and nils the websocket' do
                expect(ws).to receive(:close)
                socket.disconnect!
              end
            end

            context 'consumes data' do
              it 'runs' do
                expect(ws).to receive(:emit)
                expect(ws).to receive(:start)
                expect(logger).to receive(:debug).with("#{test_socket}#run_loop")
                socket.run_loop
              end
            end
          end

          pending 'send_data'
        end
      end
    end
  end
rescue LoadError
end
