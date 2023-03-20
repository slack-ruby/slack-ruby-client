# frozen_string_literal: true
# This file was auto-generated by lib/tasks/web.rake

require 'spec_helper'

RSpec.describe Slack::Web::Api::Endpoints::AdminConversations do
  let(:client) { Slack::Web::Client.new }
  context 'admin.conversations_archive' do
    it 'requires channel_id' do
      expect { client.admin_conversations_archive }.to raise_error ArgumentError, /Required arguments :channel_id missing/
    end
  end
  context 'admin.conversations_bulkArchive' do
    it 'requires channel_ids' do
      expect { client.admin_conversations_bulkArchive }.to raise_error ArgumentError, /Required arguments :channel_ids missing/
    end
  end
  context 'admin.conversations_bulkDelete' do
    it 'requires channel_ids' do
      expect { client.admin_conversations_bulkDelete }.to raise_error ArgumentError, /Required arguments :channel_ids missing/
    end
  end
  context 'admin.conversations_bulkMove' do
    it 'requires channel_ids' do
      expect { client.admin_conversations_bulkMove(target_team_id: %q[]) }.to raise_error ArgumentError, /Required arguments :channel_ids missing/
    end
    it 'requires target_team_id' do
      expect { client.admin_conversations_bulkMove(channel_ids: %q[]) }.to raise_error ArgumentError, /Required arguments :target_team_id missing/
    end
  end
  context 'admin.conversations_convertToPrivate' do
    it 'requires channel_id' do
      expect { client.admin_conversations_convertToPrivate }.to raise_error ArgumentError, /Required arguments :channel_id missing/
    end
  end
  context 'admin.conversations_convertToPublic' do
    it 'requires channel_id' do
      expect { client.admin_conversations_convertToPublic }.to raise_error ArgumentError, /Required arguments :channel_id missing/
    end
  end
  context 'admin.conversations_create' do
    it 'requires is_private' do
      expect { client.admin_conversations_create(name: %q[]) }.to raise_error ArgumentError, /Required arguments :is_private missing/
    end
    it 'requires name' do
      expect { client.admin_conversations_create(is_private: %q[]) }.to raise_error ArgumentError, /Required arguments :name missing/
    end
  end
  context 'admin.conversations_delete' do
    it 'requires channel_id' do
      expect { client.admin_conversations_delete }.to raise_error ArgumentError, /Required arguments :channel_id missing/
    end
  end
  context 'admin.conversations_disconnectShared' do
    it 'requires channel_id' do
      expect { client.admin_conversations_disconnectShared }.to raise_error ArgumentError, /Required arguments :channel_id missing/
    end
  end
  context 'admin.conversations_getConversationPrefs' do
    it 'requires channel_id' do
      expect { client.admin_conversations_getConversationPrefs }.to raise_error ArgumentError, /Required arguments :channel_id missing/
    end
  end
  context 'admin.conversations_getCustomRetention' do
    it 'requires channel_id' do
      expect { client.admin_conversations_getCustomRetention }.to raise_error ArgumentError, /Required arguments :channel_id missing/
    end
  end
  context 'admin.conversations_getTeams' do
    it 'requires channel_id' do
      expect { client.admin_conversations_getTeams }.to raise_error ArgumentError, /Required arguments :channel_id missing/
    end
  end
  context 'admin.conversations_invite' do
    it 'requires channel_id' do
      expect { client.admin_conversations_invite(user_ids: %q[]) }.to raise_error ArgumentError, /Required arguments :channel_id missing/
    end
    it 'requires user_ids' do
      expect { client.admin_conversations_invite(channel_id: %q[]) }.to raise_error ArgumentError, /Required arguments :user_ids missing/
    end
  end
  context 'admin.conversations_lookup' do
    it 'requires last_message_activity_before' do
      expect { client.admin_conversations_lookup(team_ids: %q[]) }.to raise_error ArgumentError, /Required arguments :last_message_activity_before missing/
    end
    it 'requires team_ids' do
      expect { client.admin_conversations_lookup(last_message_activity_before: %q[]) }.to raise_error ArgumentError, /Required arguments :team_ids missing/
    end
  end
  context 'admin.conversations_removeCustomRetention' do
    it 'requires channel_id' do
      expect { client.admin_conversations_removeCustomRetention }.to raise_error ArgumentError, /Required arguments :channel_id missing/
    end
  end
  context 'admin.conversations_rename' do
    it 'requires channel_id' do
      expect { client.admin_conversations_rename(name: %q[]) }.to raise_error ArgumentError, /Required arguments :channel_id missing/
    end
    it 'requires name' do
      expect { client.admin_conversations_rename(channel_id: %q[]) }.to raise_error ArgumentError, /Required arguments :name missing/
    end
  end
  context 'admin.conversations_setConversationPrefs' do
    it 'requires channel_id' do
      expect { client.admin_conversations_setConversationPrefs(prefs: %q[]) }.to raise_error ArgumentError, /Required arguments :channel_id missing/
    end
    it 'requires prefs' do
      expect { client.admin_conversations_setConversationPrefs(channel_id: %q[]) }.to raise_error ArgumentError, /Required arguments :prefs missing/
    end
    it 'encodes prefs as json' do
      expect(client).to receive(:post).with('admin.conversations.setConversationPrefs', channel_id: %q[], prefs: %q[{"data":["data"]}])
      client.admin_conversations_setConversationPrefs(channel_id: %q[], prefs: {:data=>["data"]})
    end
  end
  context 'admin.conversations_setCustomRetention' do
    it 'requires channel_id' do
      expect { client.admin_conversations_setCustomRetention(duration_days: %q[]) }.to raise_error ArgumentError, /Required arguments :channel_id missing/
    end
    it 'requires duration_days' do
      expect { client.admin_conversations_setCustomRetention(channel_id: %q[]) }.to raise_error ArgumentError, /Required arguments :duration_days missing/
    end
  end
  context 'admin.conversations_setTeams' do
    it 'requires channel_id' do
      expect { client.admin_conversations_setTeams }.to raise_error ArgumentError, /Required arguments :channel_id missing/
    end
  end
  context 'admin.conversations_unarchive' do
    it 'requires channel_id' do
      expect { client.admin_conversations_unarchive }.to raise_error ArgumentError, /Required arguments :channel_id missing/
    end
  end
end
