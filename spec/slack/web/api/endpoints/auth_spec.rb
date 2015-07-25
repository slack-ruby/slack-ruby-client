require 'spec_helper'

RSpec.describe Slack::Web::Api::Endpoints::Auth do
  let(:client) { Slack::Web::Client.new }
  context 'without auth', vcr: { cassette_name: 'web/auth_test_error' } do
    it 'fails with an exception' do
      expect { client.auth_test }.to raise_error Slack::Web::Api::Error
    end
  end
  context 'with auth', vcr: { cassette_name: 'web/auth_test_success' } do
    it 'succeeds' do
      expect { client.auth_test }.to_not raise_error
    end
  end
end
