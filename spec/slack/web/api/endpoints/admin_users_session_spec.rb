# frozen_string_literal: true
# This file was auto-generated by lib/tasks/web.rake

require 'spec_helper'

RSpec.describe Slack::Web::Api::Endpoints::AdminUsersSession do
  let(:client) { Slack::Web::Client.new }
  context 'admin.users.session_clearSettings' do
    it 'requires user_ids' do
      expect { client.admin_users_session_clearSettings }.to raise_error ArgumentError, /Required arguments :user_ids missing/
    end
  end
  context 'admin.users.session_getSettings' do
    it 'requires user_ids' do
      expect { client.admin_users_session_getSettings }.to raise_error ArgumentError, /Required arguments :user_ids missing/
    end
  end
  context 'admin.users.session_invalidate' do
    it 'requires session_id' do
      expect { client.admin_users_session_invalidate }.to raise_error ArgumentError, /Required arguments :session_id missing/
    end
  end
  context 'admin.users.session_reset' do
    it 'requires user_id' do
      expect { client.admin_users_session_reset }.to raise_error ArgumentError, /Required arguments :user_id missing/
    end
  end
  context 'admin.users.session_resetBulk' do
    it 'requires user_ids' do
      expect { client.admin_users_session_resetBulk }.to raise_error ArgumentError, /Required arguments :user_ids missing/
    end
  end
  context 'admin.users.session_setSettings' do
    it 'requires user_ids' do
      expect { client.admin_users_session_setSettings }.to raise_error ArgumentError, /Required arguments :user_ids missing/
    end
  end
end
