require 'spec_helper'

RSpec.describe Slack::Web::Client do
  let(:client) { Slack::Web::Client.new }
  it 'raises a Faraday::ClientError when Slack is unavailable', vcr: { cassette_name: 'web/503_error' } do
    begin
      client.auth_test
      raise 'Expected to receive Faraday::ClientError.'
    rescue Faraday::ClientError => e
      expect(e.response).to_not be_nil
      expect(e.response[:status]).to eq 503
    end
  end
end
