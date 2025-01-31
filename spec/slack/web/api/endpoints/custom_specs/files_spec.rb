# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Slack::Web::Api::Endpoints::Files do
  let(:client) { Slack::Web::Client.new }
  let(:valid_params) do
    { filename: 'test.txt', content: 'Test File Contents', channels: 'C08AZ76CA4V' }
  end

  context 'when filename is missing from options' do
    before do
      valid_params.delete(:filename)
    end

    it 'throws argument error' do
      expect { client.files_upload_v2(valid_params) }.to raise_error ArgumentError
    end
  end

  context 'when channels is missing from options' do
    before do
      valid_params.delete(:channels)
    end

    it 'throws argument error' do
      expect { client.files_upload_v2(valid_params) }.to raise_error ArgumentError
    end
  end

  context 'when content is missing from options' do
    before do
      valid_params.delete(:content)
    end

    it 'throws argument error' do
      expect { client.files_upload_v2(valid_params) }.to raise_error ArgumentError
    end
  end

  context 'when all required options are sent', vcr: { cassette_name: 'web/files_upload_v2' } do
    it 'completes the upload' do
      client.files_upload_v2(valid_params)
    end
  end
end
