# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Slack::Web::Api::Error do
  let(:client) { Slack::Web::Client.new }

  it 'provides access to the response object', vcr: { cassette_name: 'web/auth_test_error' } do
    begin
      client.auth_test
      raise 'Expected to receive Slack::Web::Api::Error.'
    rescue described_class => e
      expect(e.response).not_to be_nil
      expect(e.response.status).to eq 200
    end
  end
end
