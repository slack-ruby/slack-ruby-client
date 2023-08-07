# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Slack::RealTime::Concurrency::Async::Socket, if: ENV['CONCURRENCY'] == 'async-websocket' do
  context 'global config' do
    let(:client) { described_class.new(nil) }

    context 'run_async' do
      it 'returns an Async::Task' do
        expect(client.run_async {}).to be_a Async::Task
      end
    end
  end
end
