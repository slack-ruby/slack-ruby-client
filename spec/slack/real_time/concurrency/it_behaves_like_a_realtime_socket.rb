# frozen_string_literal: true
require 'spec_helper'

RSpec.shared_examples_for 'a realtime socket' do
  let(:url) { 'wss://ms174.slack-msgs.com/websocket/xyz' }
  let(:logger) { ::Logger.new($stdout) }
  let(:socket) { described_class.new(url, ping: 42, logger: logger) }
  describe '#initialize' do
    it 'sets url' do
      expect(socket.url).to eq url
    end
  end

  describe 'api' do
    %i[start_sync start_sync disconnect! connect! connected? send_data close].each do |m|
      it m do
        expect(socket).to respond_to(m)
      end
    end
  end
end
