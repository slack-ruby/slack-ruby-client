# frozen_string_literal: true
require 'spec_helper'

RSpec.describe 'without CONCURRENCY', skip: ( # rubocop:disable RSpec/DescribeClass
  (ENV['CONCURRENCY']) && 'CONCURRENCY is set'
) do
  it 'raises NoConcurrencyError' do
    expect { Slack::RealTime::Config.concurrency }.to raise_error Slack::RealTime::Config::NoConcurrencyError
  end
end
