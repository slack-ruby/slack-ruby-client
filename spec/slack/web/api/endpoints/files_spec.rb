# frozen_string_literal: true
# This file was auto-generated by lib/tasks/web.rake

require 'spec_helper'

RSpec.describe Slack::Web::Api::Endpoints::Files do
  let(:client) { Slack::Web::Client.new }
  context 'files_completeUploadExternal' do
    it 'requires files' do
      expect { client.files_completeUploadExternal }.to raise_error ArgumentError, /Required arguments :files missing/
    end
    it 'encodes blocks as json' do
      expect(client).to receive(:post).with('files.completeUploadExternal', {files: %q[[{"id":"F044GKUHN9Z", "title":"slack-test"}]], blocks: %q[{"data":["data"]}]})
      client.files_completeUploadExternal(files: %q[[{"id":"F044GKUHN9Z", "title":"slack-test"}]], blocks: {:data=>["data"]})
    end
  end
  context 'files_delete' do
    it 'requires file' do
      expect { client.files_delete }.to raise_error ArgumentError, /Required arguments :file missing/
    end
  end
  context 'files_edit' do
    it 'requires file' do
      expect { client.files_edit(title: %q[Brand new title]) }.to raise_error ArgumentError, /Required arguments :file missing/
    end
    it 'requires title' do
      expect { client.files_edit(file: %q[F2147483862]) }.to raise_error ArgumentError, /Required arguments :title missing/
    end
  end
  context 'files_getUploadURLExternal' do
    it 'requires filename' do
      expect { client.files_getUploadURLExternal(length: %q[53072]) }.to raise_error ArgumentError, /Required arguments :filename missing/
    end
    it 'requires length' do
      expect { client.files_getUploadURLExternal(filename: %q[laughingoutloudcat.jpg]) }.to raise_error ArgumentError, /Required arguments :length missing/
    end
  end
  context 'files_info' do
    it 'requires file' do
      expect { client.files_info }.to raise_error ArgumentError, /Required arguments :file missing/
    end
  end
  context 'files_revokePublicURL' do
    it 'requires file' do
      expect { client.files_revokePublicURL }.to raise_error ArgumentError, /Required arguments :file missing/
    end
  end
  context 'files_share' do
    it 'requires file' do
      expect { client.files_share(channel: %q[C1234567890]) }.to raise_error ArgumentError, /Required arguments :file missing/
    end
    it 'requires channel' do
      expect { client.files_share(file: %q[F2147483862]) }.to raise_error ArgumentError, /Required arguments :channel missing/
    end
  end
  context 'files_sharedPublicURL' do
    it 'requires file' do
      expect { client.files_sharedPublicURL }.to raise_error ArgumentError, /Required arguments :file missing/
    end
  end
end
