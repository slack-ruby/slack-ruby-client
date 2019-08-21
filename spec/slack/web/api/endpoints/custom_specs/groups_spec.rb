# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Slack::Web::Api::Endpoints::Groups do
  let(:client) { Slack::Web::Client.new }

  context 'groups' do
    it 'info', vcr: { cassette_name: 'web/groups_info' } do
      json = client.groups_info(channel: '#mpdm-dblock--rubybot--player1-1')
      expect(json.group.name).to eq 'mpdm-dblock--rubybot--player1-1'
    end
  end
end
