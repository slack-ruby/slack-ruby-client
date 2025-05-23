# frozen_string_literal: true
# This file was auto-generated by lib/tasks/web.rake

require 'spec_helper'

RSpec.describe Slack::Web::Api::Endpoints::AssistantSearch do
  let(:client) { Slack::Web::Client.new }
  context 'assistant.search_context' do
    it 'requires query' do
      expect { client.assistant_search_context }.to raise_error ArgumentError, /Required arguments :query missing/
    end
  end
end
