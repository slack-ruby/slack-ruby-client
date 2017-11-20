# This file was auto-generated by lib/tasks/web.rake

require 'spec_helper'

RSpec.describe Slack::Web::Api::Endpoints::Files do
  let(:client) { Slack::Web::Client.new }
  context 'files_sharedPublicURL' do
    it 'requires file' do
      expect { client.files_sharedPublicURL }.to raise_error ArgumentError, /Required arguments :file missing/
    end
  end
  context 'files_revokePublicURL' do
    it 'requires file' do
      expect { client.files_revokePublicURL }.to raise_error ArgumentError, /Required arguments :file missing/
    end
  end
  context 'files_info' do
    it 'requires file' do
      expect { client.files_info }.to raise_error ArgumentError, /Required arguments :file missing/
    end
  end
  context 'files_delete' do
    it 'requires file' do
      expect { client.files_delete }.to raise_error ArgumentError, /Required arguments :file missing/
    end
  end
end
