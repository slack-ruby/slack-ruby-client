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
    it 'translates a user that starts with a #' do
      expect(users.users_id(user: '@aws')).to eq('ok' => true, 'user' => { 'id' => 'UDEADBEEF' })
    end
    it 'fails with an exception' do
      expect { users.users_id(user: '@foo') }.to(
        raise_error(Slack::Web::Api::Errors::SlackError, 'user_not_found')
      )
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
