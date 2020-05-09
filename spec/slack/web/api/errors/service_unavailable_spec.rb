# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Slack::Web::Client do
  let(:client) { described_class.new }

  it 'raises a Faraday::ClientError when Slack is unavailable',
     vcr: { cassette_name: 'web/503_error' } do
    begin
      client.auth_test
      raise 'Expected to receive Faraday::ServerError.'
    rescue Faraday::ServerError => e
      expect(e.response).not_to be_nil
      expect(e.response[:status]).to eq 503
    end
  end
end
