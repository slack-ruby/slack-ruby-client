# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Slack::Web::Client do
  subject(:client) { described_class.new(token: 'example-token') }

  before do
    stub_request(:post, 'https://slack.com/api/auth.test').to_return(
      body: '{"ok":true}',
      headers: { 'Content-Type' => 'application/json', 'X-OAuth-Scopes' => 'chat:write' }
    )
  end

  it 'returns a configured copy without changing body returns' do
    responses = []
    observed = client.with_response { |response| responses << response }
    result = observed.auth_test
    expect(result).to be_a(Slack::Messages::Message)
    expect(responses.first.body).to equal(result)
    expect(responses.first.headers['x-oauth-scopes']).to eq('chat:write')
    expect(observed.token).to eq(client.token)
    client.auth_test
    expect(responses.size).to eq(1)
  end

  it 'chains request and response callbacks in registration order' do
    calls = []
    observed = client.with_request do |request|
      calls << :request
      request.headers['X-Custom'] = 'value'
    end
    observed = observed.with_response do |response|
      calls << response.status
    end
    observed = observed.with_response do
      calls << :second
    end
    observed.auth_test
    expect(calls).to eq([:request, 200, :second])
    expect(a_request(:post, 'https://slack.com/api/auth.test')
      .with(headers: { 'X-Custom' => 'value', 'Authorization' => 'Bearer example-token' })).to have_been_made.once
  end

  it 'requires callback blocks' do
    expect { client.with_response }.to raise_error(ArgumentError, 'response callback block is required')
    expect { client.with_request }.to raise_error(ArgumentError, 'request callback block is required')
  end

  it 'observes every pagination request while preserving page blocks' do
    stub_request(:post, 'https://slack.com/api/users.list')
      .to_return(body: '{"ok":true,"members":[{"id":"U1"}],"response_metadata":{"next_cursor":"next"}}')
      .then.to_return(body: '{"ok":true,"members":[{"id":"U2"}],"response_metadata":{"next_cursor":""}}')
    requests = []
    responses = []
    pages = []
    observed = client.with_request { |request| requests << request }
    observed = observed.with_response { |response| responses << response }
    observed.users_list { |page| pages << page }
    expect(requests.size).to eq(2)
    expect(responses.map(&:body)).to eq(pages)
    expect(pages.map { |page| page.members.first.id }).to eq(%w[U1 U2])
  end

  it 'does not share cached connections' do
    original_connection = client.send(:connection)
    observed = client.with_response { |_response| nil }
    expect(observed.send(:connection)).not_to equal(original_connection)
  end

  it 'propagates response callback errors unchanged' do
    error = Faraday::ParsingError.new('callback error')
    observed = client.with_response { raise error }
    expect { observed.auth_test }.to(raise_error { |raised| expect(raised).to equal(error) })
  end

  it 'does not dispatch an HTTP request when a request callback fails' do
    observed = client.with_request { raise ArgumentError, 'callback error' }
    expect { observed.auth_test }.to raise_error(ArgumentError, 'callback error')
    expect(a_request(:post, 'https://slack.com/api/auth.test')).not_to have_been_made
  end

  it 'does not translate parsing errors raised by request callbacks' do
    error = Faraday::ParsingError.new('callback error')
    observed = client.with_request { raise error }
    expect { observed.auth_test }.to(raise_error { |raised| expect(raised).to equal(error) })
  end

  it 'does not call response callbacks on Slack errors' do
    stub_request(:post, 'https://slack.com/api/auth.test').to_return(body: '{"ok":false,"error":"not_authed"}')
    responses = []
    observed = client.with_response { |response| responses << response }
    expect { observed.auth_test }.to raise_error(Slack::Web::Api::Errors::SlackError)
    expect(responses).to be_empty
  end

  it 'does not call response callbacks on transport errors' do
    stub_request(:post, 'https://slack.com/api/auth.test').to_timeout
    responses = []
    observed = client.with_response { |response| responses << response }
    expect { observed.auth_test }.to raise_error(Slack::Web::Api::Errors::TimeoutError)
    expect(responses).to be_empty
  end
end
