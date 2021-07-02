# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Slack::Web::Faraday::Response::StoreScopes do
  let(:store_scopes_obj) { described_class.new(app, client: client) }
  let(:app) { proc {} }
  let(:client) { Slack::Web::Client.new }
  let(:env) { instance_double(Faraday::Env, response_headers: response_headers) }

  describe '#on_complete' do
    subject(:on_complete) { store_scopes_obj.on_complete(env) }

    context 'with no x-oauth-scopes header' do
      let(:response_headers) { Faraday::Utils::Headers.new }

      it 'does not set oauth_scopes on the client' do
        on_complete
        expect(client.oauth_scopes).to be_nil
      end
    end

    context 'with x-oauth-scopes in an unexpected format' do
      let(:raw_scopes) { 'this is not what scopes look like' }
      let(:response_headers) { Faraday::Utils::Headers.new('x-oauth-scopes': raw_scopes) }

      it 'does not crash' do
        on_complete
        expect(client.oauth_scopes).to contain_exactly(raw_scopes)
      end
    end

    context 'with x-oauth-scopes in an expected format' do
      let(:scopes) { %w[chat:write chat:write.public chat:write:user commands identity.basic] }
      let(:response_headers) { Faraday::Utils::Headers.new('x-oauth-scopes': scopes.join(',')) }

      it 'parses the scopes into an array' do
        on_complete
        expect(client.oauth_scopes).to match_array(scopes)
      end
    end
  end
end
