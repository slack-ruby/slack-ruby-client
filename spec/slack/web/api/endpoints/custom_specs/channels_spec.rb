# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Slack::Web::Api::Endpoints::Channels do
  let(:client) { Slack::Web::Client.new }

  context 'channels' do
    it 'raises deprecation error', vcr: { cassette_name: 'web/channels_info' } do
      expect { client.channels_info(channel: '#general') }
        .to raise_error(Slack::Web::Api::Errors::MethodDeprecated, 'method_deprecated')
    end
  end
end
