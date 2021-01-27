# frozen_string_literal: true
require 'spec_helper'

RSpec.describe 'with CONCURRENCY', skip: ( # rubocop:disable RSpec/DescribeClass
  (!ENV['CONCURRENCY']) && 'missing CONCURRENCY'
) do
  it 'detects concurrency' do
    expect(Slack::RealTime::Config.concurrency).to eq Slack::RealTime::Concurrency::Async
  end
end
