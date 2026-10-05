# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Slack::Web::Client do
  subject(:client) { described_class.new(token: 'example-token') }

  it 'observes Slack errors and re-raises the same exception' do
    stub_request(:post, 'https://slack.com/api/auth.test').to_return(
      body: '{"ok":false,"error":"invalid_arguments","response_metadata":{"messages":["missing field"]}}'
    )
    errors = []
    observed = client.with_error { |error| errors << error }
    expect { observed.auth_test }.to(raise_error do |error|
      expect(error).to equal(errors.first)
      expect(error.response_metadata.messages).to eq(['missing field'])
      expect(error.backtrace.first).to include('raise_error.rb')
    end)
    expect(errors.size).to eq(1)
  end

  it 'does not mutate the original client' do
    stub_request(:post, 'https://slack.com/api/auth.test').to_timeout
    errors = []
    client.with_error { |error| errors << error }
    expect { client.auth_test }.to raise_error(Slack::Web::Api::Errors::TimeoutError)
    expect(errors).to be_empty
  end

  it 'observes transport errors' do
    stub_request(:post, 'https://slack.com/api/auth.test').to_timeout
    errors = []
    observed = client.with_error { |error| errors << error }
    expect { observed.auth_test }.to raise_error(Slack::Web::Api::Errors::TimeoutError)
    expect(errors.first).to be_a(Slack::Web::Api::Errors::TimeoutError)
  end

  it 'observes translated parsing errors' do
    stub_request(:post, 'https://slack.com/api/auth.test').to_return(body: 'not json')
    errors = []
    observed = client.with_error { |error| errors << error }
    expect { observed.auth_test }.to(raise_error do |error|
      expect(error).to be_a(Slack::Web::Api::Errors::ParsingError)
      expect(error).to equal(errors.first)
      expect(error.cause).to be_a(Faraday::ParsingError)
    end)
  end

  it 'observes each pagination retry without stopping retries' do
    stub_request(:post, 'https://slack.com/api/users.list')
      .to_return(status: 429, headers: { 'Retry-After' => '0' }, body: '{"ok":false}')
      .then.to_return(body: '{"ok":true,"members":[]}')
    errors = []
    responses = []
    observed = client.with_error { |error| errors << error }
    observed = observed.with_response { |response| responses << response }
    pages = []
    observed.users_list { |page| pages << page }
    expect(errors.first).to be_a(Slack::Web::Api::Errors::TooManyRequestsError)
    expect(errors.size).to eq(1)
    expect(responses.map(&:body)).to eq(pages)
    expect(pages.size).to eq(1)
  end

  it 'registers chained error callbacks in order' do
    stub_request(:post, 'https://slack.com/api/auth.test').to_timeout
    calls = []
    observed = client.with_error { calls << 1 }.with_error { calls << 2 }
    expect { observed.auth_test }.to raise_error(Slack::Web::Api::Errors::TimeoutError)
    expect(calls).to eq([1, 2])
  end

  %i[with_request with_response].each do |callback_method|
    it "does not observe exceptions from #{callback_method} callbacks" do
      stub_request(:post, 'https://slack.com/api/auth.test').to_return(body: '{"ok":true}')
      errors = []
      observed = client.with_error { |error| errors << error }
      callback_error = Faraday::ParsingError.new('callback error')
      observed = observed.public_send(callback_method) { raise callback_error }
      expect { observed.auth_test }.to(raise_error { |error| expect(error).to equal(callback_error) })
      expect(errors).to be_empty
    end
  end

  it 'propagates error callback failures without recursive notification' do
    stub_request(:post, 'https://slack.com/api/auth.test').to_timeout
    calls = []
    observed = client.with_error do
      calls << :called
      raise ArgumentError, 'observer failed'
    end
    expect { observed.auth_test }.to raise_error(ArgumentError, 'observer failed')
    expect(calls).to eq([:called])
  end

  it 'requires a block' do
    expect { client.with_error }.to raise_error(ArgumentError, 'error callback block is required')
  end
end
