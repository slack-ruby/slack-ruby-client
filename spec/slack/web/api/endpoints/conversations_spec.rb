# frozen_string_literal: true
# This file was auto-generated by lib/tasks/web.rake

require 'spec_helper'

RSpec.describe Slack::Web::Api::Endpoints::Conversations do
  let(:client) { Slack::Web::Client.new }
  context 'conversations_acceptSharedInvite' do
    it 'requires channel_name' do
      expect { client.conversations_acceptSharedInvite }.to raise_error ArgumentError, /Required arguments :channel_name missing/
    end
  end
  context 'conversations_approveSharedInvite' do
    it 'requires invite_id' do
      expect { client.conversations_approveSharedInvite }.to raise_error ArgumentError, /Required arguments :invite_id missing/
    end
  end
  context 'conversations_archive' do
    it 'requires channel' do
      expect { client.conversations_archive }.to raise_error ArgumentError, /Required arguments :channel missing/
    end
  end
  context 'conversations_close' do
    it 'requires channel' do
      expect { client.conversations_close }.to raise_error ArgumentError, /Required arguments :channel missing/
    end
  end
  context 'conversations_create' do
    it 'requires name' do
      expect { client.conversations_create }.to raise_error ArgumentError, /Required arguments :name missing/
    end
  end
  context 'conversations_declineSharedInvite' do
    it 'requires invite_id' do
      expect { client.conversations_declineSharedInvite }.to raise_error ArgumentError, /Required arguments :invite_id missing/
    end
  end
  context 'conversations_history' do
    it 'requires channel' do
      expect { client.conversations_history }.to raise_error ArgumentError, /Required arguments :channel missing/
    end
  end
  context 'conversations_info' do
    it 'requires channel' do
      expect { client.conversations_info }.to raise_error ArgumentError, /Required arguments :channel missing/
    end
  end
  context 'conversations_invite' do
    it 'requires channel' do
      expect { client.conversations_invite(users: %q[W1234567890,U2345678901,U3456789012]) }.to raise_error ArgumentError, /Required arguments :channel missing/
    end
    it 'requires users' do
      expect { client.conversations_invite(channel: %q[C1234567890]) }.to raise_error ArgumentError, /Required arguments :users missing/
    end
  end
  context 'conversations_inviteShared' do
    it 'requires channel' do
      expect { client.conversations_inviteShared }.to raise_error ArgumentError, /Required arguments :channel missing/
    end
  end
  context 'conversations_join' do
    it 'requires channel' do
      expect { client.conversations_join }.to raise_error ArgumentError, /Required arguments :channel missing/
    end
  end
  context 'conversations_kick' do
    it 'requires channel' do
      expect { client.conversations_kick }.to raise_error ArgumentError, /Required arguments :channel missing/
    end
  end
  context 'conversations_leave' do
    it 'requires channel' do
      expect { client.conversations_leave }.to raise_error ArgumentError, /Required arguments :channel missing/
    end
  end
  context 'conversations_mark' do
    it 'requires channel' do
      expect { client.conversations_mark(ts: %q[1593473566.000200]) }.to raise_error ArgumentError, /Required arguments :channel missing/
    end
    it 'requires ts' do
      expect { client.conversations_mark(channel: %q[C012345678]) }.to raise_error ArgumentError, /Required arguments :ts missing/
    end
  end
  context 'conversations_members' do
    it 'requires channel' do
      expect { client.conversations_members }.to raise_error ArgumentError, /Required arguments :channel missing/
    end
  end
  context 'conversations_rename' do
    it 'requires channel' do
      expect { client.conversations_rename(name: %q[]) }.to raise_error ArgumentError, /Required arguments :channel missing/
    end
    it 'requires name' do
      expect { client.conversations_rename(channel: %q[C1234567890]) }.to raise_error ArgumentError, /Required arguments :name missing/
    end
  end
  context 'conversations_replies' do
    it 'requires channel' do
      expect { client.conversations_replies(ts: %q[1234567890.123456]) }.to raise_error ArgumentError, /Required arguments :channel missing/
    end
    it 'requires ts' do
      expect { client.conversations_replies(channel: %q[C1234567890]) }.to raise_error ArgumentError, /Required arguments :ts missing/
    end
  end
  context 'conversations_setPurpose' do
    it 'requires channel' do
      expect { client.conversations_setPurpose(purpose: %q[This is the random channel, anything goes!]) }.to raise_error ArgumentError, /Required arguments :channel missing/
    end
    it 'requires purpose' do
      expect { client.conversations_setPurpose(channel: %q[C1234567890]) }.to raise_error ArgumentError, /Required arguments :purpose missing/
    end
  end
  context 'conversations_setTopic' do
    it 'requires channel' do
      expect { client.conversations_setTopic(topic: %q[Apply topically for best effects]) }.to raise_error ArgumentError, /Required arguments :channel missing/
    end
    it 'requires topic' do
      expect { client.conversations_setTopic(channel: %q[C1234567890]) }.to raise_error ArgumentError, /Required arguments :topic missing/
    end
  end
  context 'conversations_unarchive' do
    it 'requires channel' do
      expect { client.conversations_unarchive }.to raise_error ArgumentError, /Required arguments :channel missing/
    end
  end
end
