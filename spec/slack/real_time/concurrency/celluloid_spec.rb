# frozen_string_literal: true
require 'spec_helper'
require_relative './it_behaves_like_a_realtime_socket'

begin
  RSpec.describe Slack::RealTime::Concurrency::Celluloid::Socket do
    subject { socket }

    let(:driver) { WebSocket::Driver::Client }
    let(:logger) { ::Logger.new(STDOUT) }
    let(:ws) { double(driver) }
    let(:url) { 'wss://echo.websocket.org/websocket/xyz' }

    it_behaves_like 'a realtime socket'

    ['', nil].each do |data|
      context "finishing run_loop with #{data ? 'empty' : 'nil'} read" do
        let(:ssl_socket) do
          Class.new(Celluloid::IO::SSLSocket) do
            def initialize(data)
              @data = data
            end

            def connect; end

            def readpartial(_size)
              @data
            end
          end
        end

        let(:test_socket) do
          Class.new(described_class) do
            def build_socket
              options[:ssl_socket].new(options[:data])
            end
          end
        end

        let(:socket) do
          test_socket.new(url, logger: logger, data: data, ssl_socket: ssl_socket)
        end

        context 'with a driver' do
          before do
            socket.instance_variable_set('@driver', ws)
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
      end
    end

    [EOFError, Errno::ECONNRESET, Errno::EPIPE].each do |err|
      context "finishing run_loop with #{err}" do
        let(:test_socket) do
          Class.new(described_class) do
            def read
              raise options[:err]
            end
          end
        end

        let(:socket) do
          test_socket.new(url, logger: logger, err: err)
        end

        context 'with a driver' do
          before do
            socket.instance_variable_set('@driver', ws)
          end

          describe '#disconnect!' do
            it 'closes and nils the websocket' do
              expect(ws).to receive(:emit)
              expect(ws).to receive(:close)
              socket.disconnect!
            end
          end

          context 'consumes data' do
            let(:tcp_socket) { double(::Celluloid::IO::SSLSocket, connect: true) }

            before do
              allow_any_instance_of(described_class).to(
                receive(:build_socket).and_return(tcp_socket)
              )
            end

            it 'runs' do
              expect(ws).to receive(:emit)
              expect(ws).to receive(:start)
              expect(logger).to receive(:debug).with("#{test_socket}#run_loop")
              socket.run_loop
            end
          end
        end
      end
    end

    describe '#connect!' do
      pending 'connects'
      pending 'pings every 30s'
    end

    pending 'send_data'
  end
rescue LoadError
end
