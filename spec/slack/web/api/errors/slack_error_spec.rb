# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Slack::Web::Api::Errors::SlackError do
  let(:client) { Slack::Web::Client.new }

  it 'provides access to useful info', vcr: { cassette_name: 'web/views_open_error' } do
    begin
      client.views_open(trigger_id: 'trigger_id', view: {})
      raise 'Expected to receive Slack::Web::Api::Errors::SlackError.'
    rescue described_class => e
      expect(e.response).not_to be_nil
      expect(e.response.status).to eq 200
      expect(e.error).to eql 'invalid_arguments'
      expect(e.response_metadata).to eq(
        'messages' => [
          "[ERROR] missing required field: title [json-pointer:\/view]",
          "[ERROR] missing required field: blocks [json-pointer:\/view]",
          "[ERROR] missing required field: type [json-pointer:\/view]"
        ]
      )
    end
  end
end
