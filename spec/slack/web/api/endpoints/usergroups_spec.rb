# This file was auto-generated by lib/tasks/web.rake

require 'spec_helper'

RSpec.describe Slack::Web::Api::Endpoints::Usergroups do
  let(:client) { Slack::Web::Client.new }
  context 'usergroups_create' do
    it 'requires name' do
      expect { client.usergroups_create }.to raise_error ArgumentError, /Required arguments :name missing/
    end
  end
  context 'usergroups_disable' do
    it 'requires usergroup' do
      expect { client.usergroups_disable }.to raise_error ArgumentError, /Required arguments :usergroup missing/
    end
  end
  context 'usergroups_enable' do
    it 'requires usergroup' do
      expect { client.usergroups_enable }.to raise_error ArgumentError, /Required arguments :usergroup missing/
    end
  end
  context 'usergroups_update' do
    it 'requires usergroup' do
      expect { client.usergroups_update }.to raise_error ArgumentError, /Required arguments :usergroup missing/
    end
  end
  context 'usergroups_users_update' do
    it 'requires usergroup' do
      expect { client.usergroups_users_update(users: 'U060R4BJ4,U060RNRCZ') }.to raise_error ArgumentError, /Required arguments :usergroup missing/
    end
    it 'requires users' do
      expect { client.usergroups_users_update(usergroup: 'S0604QSJC') }.to raise_error ArgumentError, /Required arguments :users missing/
    end
  end
  context 'usergroups_users_list' do
    it 'requires usergroup' do
      expect { client.usergroups_users_list(users: 'U060R4BJ4,U060RNRCZ') }.to raise_error ArgumentError, /Required arguments :usergroup missing/
    end
  end
end
