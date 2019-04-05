require 'spec_helper'
require_relative './it_behaves_like_a_realtime_socket'

begin
  RSpec.describe Slack::RealTime::Concurrency::Async::Socket do
    it_behaves_like 'a realtime socket'
  end
rescue LoadError
end
