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
      expect(cursor).not_to receive(:sleep)
      cursor.to_a
    end
    context 'with rate limiting' do
      let(:error) { Slack::Web::Api::Errors::TooManyRequestsError.new(nil) }
      it 'sleeps after a TooManyRequestsError' do
        expect(client).to receive(:users_list).with(limit: 100, cursor: nil).ordered.and_return(Slack::Messages::Message.new(response_metadata: { next_cursor: 'next' }))
        expect(client).to receive(:users_list).with(limit: 100, cursor: 'next').ordered.and_raise(error)
        expect(error).to receive(:retry_after).once.ordered.and_return(9)
        expect(cursor).to receive(:sleep).once.ordered.with(9)
        expect(client).to receive(:users_list).with(limit: 100, cursor: 'next').ordered.and_return(Slack::Messages::Message.new)
        cursor.to_a
      end
    end
  end
  context 'with a custom limit' do
    let(:cursor) { Slack::Web::Api::Pagination::Cursor.new(client, 'users_list', limit: 42) }
    it 'overrides default limit' do
      expect(client).to receive(:users_list).with(limit: 42, cursor: nil)
      cursor.first
    end
  end
  context 'with a custom sleep_interval' do
    let(:cursor) { Slack::Web::Api::Pagination::Cursor.new(client, 'users_list', sleep_interval: 3) }
    it 'sleeps between requests' do
      expect(client).to receive(:users_list).exactly(3).times.and_return(
        Slack::Messages::Message.new(response_metadata: { next_cursor: 'next_a' }),
        Slack::Messages::Message.new(response_metadata: { next_cursor: 'next_b' }),
        Slack::Messages::Message.new
      )
      expect(cursor).to receive(:sleep).with(3).twice
      cursor.to_a
    end
  end
end
