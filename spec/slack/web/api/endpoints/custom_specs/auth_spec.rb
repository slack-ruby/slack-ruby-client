# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Slack::Web::Api::Endpoints::Auth do
  let(:client) { Slack::Web::Client.new }

  context 'without auth', vcr: { cassette_name: 'web/auth_test_error' } do
    it 'fails with an exception' do
      expect { client.auth_test }.to raise_error Slack::Web::Api::Errors::SlackError, 'not_authed'
    end
  end

  context 'with auth', vcr: { cassette_name: 'web/auth_test_success' } do
    it 'succeeds' do
      expect { client.auth_test }.not_to raise_error
    end
  end

  context '429 error', vcr: { cassette_name: 'web/429_error' } do
    it 'fails with an specific exception' do
      begin
        client.auth_test
      rescue Slack::Web::Api::Errors::TooManyRequestsError => e
        expect(e.message).to eq('Retry after 3600 seconds')
        expect(e.retry_after).to eq(3600)
      end
    end
  end
end
