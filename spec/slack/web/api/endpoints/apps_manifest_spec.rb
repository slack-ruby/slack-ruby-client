# frozen_string_literal: true
# This file was auto-generated by lib/tasks/web.rake

require 'spec_helper'

RSpec.describe Slack::Web::Api::Endpoints::AppsManifest do
  let(:client) { Slack::Web::Client.new }
  context 'apps.manifest_create' do
    it 'requires manifest' do
      expect { client.apps_manifest_create }.to raise_error ArgumentError, /Required arguments :manifest missing/
    end
    it 'encodes manifest as json' do
      expect(client).to receive(:post).with('apps.manifest.create', manifest: %q[{"data":["data"]}])
      client.apps_manifest_create(manifest: {:data=>["data"]})
    end
  end
  context 'apps.manifest_delete' do
    it 'requires app_id' do
      expect { client.apps_manifest_delete }.to raise_error ArgumentError, /Required arguments :app_id missing/
    end
  end
  context 'apps.manifest_export' do
    it 'requires app_id' do
      expect { client.apps_manifest_export }.to raise_error ArgumentError, /Required arguments :app_id missing/
    end
  end
  context 'apps.manifest_update' do
    it 'requires app_id' do
      expect { client.apps_manifest_update(manifest: %q[]) }.to raise_error ArgumentError, /Required arguments :app_id missing/
    end
    it 'requires manifest' do
      expect { client.apps_manifest_update(app_id: %q[]) }.to raise_error ArgumentError, /Required arguments :manifest missing/
    end
    it 'encodes manifest as json' do
      expect(client).to receive(:post).with('apps.manifest.update', app_id: %q[], manifest: %q[{"data":["data"]}])
      client.apps_manifest_update(app_id: %q[], manifest: {:data=>["data"]})
    end
  end
  context 'apps.manifest_validate' do
    it 'requires manifest' do
      expect { client.apps_manifest_validate }.to raise_error ArgumentError, /Required arguments :manifest missing/
    end
  end
end
