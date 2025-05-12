# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Slack::Web::Api::Mixins::Users do
  subject(:users) do
    klass.new
  end

  let(:klass) do
    Class.new do
      include Slack::Web::Api::Mixins::Users
    end
  end

  before do
    allow(users).to receive(:users_id_page_size) { Slack::Web.config.users_id_page_size }
    allow(users).to receive(:users_list).and_yield(
      Slack::Messages::Message.new(
        'members' => [{
          'id' => 'UDEADBEEF',
          'name' => 'aws',
          'profile' => {}
        }]
      )
    )
  end

  context '#users_id' do
    it 'leaves users specified by ID alone' do
      expect(users.users_id(user: 'U123456')).to eq('ok' => true, 'user' => { 'id' => 'U123456' })
    end

    it 'translates a user that starts with a @' do
      expect(users).to receive(:users_list).with(limit: 100)
      expect(users.users_id(user: '@aws')).to eq('ok' => true, 'user' => { 'id' => 'UDEADBEEF' })
    end

    it 'forwards a provided limit to the underlying users_list calls' do
      expect(users).to receive(:users_list).with(limit: 1234)
      users.users_id(user: '@aws', id_limit: 1234)
    end

    it 'fails with an exception' do
      expect { users.users_id(user: '@foo') }.to(
        raise_error(Slack::Web::Api::Errors::SlackError, 'user_not_found')
      )
    end

    context 'when a non-default conversations_id page size has been configured' do
      before { Slack::Web.config.users_id_page_size = 500 }

      after { Slack::Web.config.reset }

      it 'translates a user that starts with a @' do
        expect(users).to receive(:users_list).with(limit: 500)
        expect(users.users_id(user: '@aws')).to eq('ok' => true, 'user' => { 'id' => 'UDEADBEEF' })
      end

      it 'forwards a provided limit to the underlying users_list calls' do
        expect(users).to receive(:users_list).with(limit: 1234)
        users.users_id(user: '@aws', id_limit: 1234)
      end
    end
  end

  if defined?(Picky)
    context '#users_search' do
      it 'finds a user' do
        expect(users.users_search(user: 'aws')).to(
          eq('ok' => true, 'members' => [{ 'id' => 'UDEADBEEF', 'name' => 'aws', 'profile' => {} }])
        )
      end
    end
  end
end
