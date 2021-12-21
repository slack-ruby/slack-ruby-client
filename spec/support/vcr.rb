# frozen_string_literal: true
require 'vcr'
require 'webmock/rspec'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/slack'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  if ENV.key?('SLACK_API_TOKEN')
    config.filter_sensitive_data('<SLACK_API_TOKEN>') do
      ENV['SLACK_API_TOKEN']
    end
  end
  config.before_record do |i|
    i.response.body.force_encoding('UTF-8')
  end
  config.register_request_matcher :client_headers do |recorded, actual|
    authorizations = ENV.key?('SLACK_API_TOKEN') ? actual.headers['Authorization'].map do |auth|
      auth.gsub(ENV['SLACK_API_TOKEN'], '<SLACK_API_TOKEN>')
    end : actual.headers['Authorization']
    actual.headers['Accept'] == recorded.headers['Accept'] &&
      authorizations == recorded.headers['Authorization']
  end
  config.default_cassette_options = {
    match_requests_on: %i[method uri body client_headers]
    # record: :new_episodes
  }
end

module VCR
  module Errors
    class UnhandledHTTPRequestError
      private

      # Force unhandled HTTP error reports to include the headers
      # for our custom matcher `client_headers`.
      #
      # This patch can be removed if https://github.com/vcr/vcr/issues/912
      # is ever resolved.
      def match_request_on_headers?
        true
      end
    end
  end
end
