require 'spec_helper'

RSpec.describe Slack::Web::Api::Pagination::Cursor do
  let(:client) { Slack::Web::Client.new }
  context 'default cursor' do
    let(:cursor) { Slack::Web::Api::Pagination::Cursor.new(client, 'users_list', {}) }
    it 'provides a default limit' do
      expect(client).to receive(:users_list).with(limit: 100, cursor: nil)
      cursor.first
    end
    it 'handles blank response metadata' do
      expect(client).to receive(:users_list).once.and_return(Slack::Messages::Message.new)
      cursor.to_a
    end
    it 'handles nil response metadata' do
      expect(client).to receive(:users_list).once.and_return(Slack::Messages::Message.new(response_metadata: nil))
      cursor.to_a
    end
    it 'paginates with a cursor inside response metadata' do
      expect(client).to receive(:users_list).twice.and_return(
        Slack::Messages::Message.new(response_metadata: { next_cursor: 'next' }),
        Slack::Messages::Message.new
      )
      cursor.to_a
    end
  end
  context 'with a custom limit' do
    let(:cursor) { Slack::Web::Api::Pagination::Cursor.new(client, 'users_list', limit: 42) }
    it 'overrides default limit' do
      expect(client).to receive(:users_list).with(limit: 42, cursor: nil)
      cursor.first
    end
  end
end
