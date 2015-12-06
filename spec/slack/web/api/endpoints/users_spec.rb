require 'spec_helper'

RSpec.describe Slack::Web::Api::Endpoints::Users do
  let(:client) { Slack::Web::Client.new }
  context 'users' do
    it 'list', vcr: { cassette_name: 'web/users_list' } do
      json = client.users_list(presence: true)
      expect(json['ok']).to be true
      expect(json['members'].size).to eq 9
      expect(json['members'].first['presence']).to eq 'away'
    end
  end
end
