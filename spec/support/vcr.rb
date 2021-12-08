# frozen_string_literal: true
require 'vcr'
require 'webmock/rspec'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/slack'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.filter_sensitive_data('<SLACK_API_TOKEN>') { ENV['SLACK_API_TOKEN'] }
  config.before_record do |i|
    i.response.body.force_encoding('UTF-8')
  end
  config.register_request_matcher :client_headers do |request1, request2|
    request1.headers['Accept'] == request2.headers['Accept'] &&
      request1.headers['Authorization'] == request2.headers['Authorization']
  end
  config.default_cassette_options = {
    match_requests_on: %i[method uri body client_headers]
    # record: :new_episodes
  }
end
