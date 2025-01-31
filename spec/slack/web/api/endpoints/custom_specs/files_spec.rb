# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Slack::Web::Api::Endpoints::Files do
  let(:client) { Slack::Web::Client.new }
  let(:required_params) do
    { filename: 'test.txt', content: 'Test File Contents', channels: 'C08AZ76CA4V' }
  end
  let(:all_params) do
    required_params.merge!({ title: 'title', initial_comment: 'initial_comment', thread_ts: '1738331914.958599',
                             snippet_type: 'text' })
  end

  context 'when filename is missing from options' do
    before do
      required_params.delete(:filename)
    end

    it 'throws argument error' do
      expect { client.files_upload_v2(required_params) }.to raise_error ArgumentError
    end
  end

  context 'when channels is missing from options' do
    before do
      required_params.delete(:channels)
    end

    it 'throws argument error' do
      expect { client.files_upload_v2(required_params) }.to raise_error ArgumentError
    end
  end

  context 'when content is missing from options' do
    before do
      required_params.delete(:content)
    end

    it 'throws argument error' do
      expect { client.files_upload_v2(required_params) }.to raise_error ArgumentError
    end
  end

  context 'when all required options are sent', vcr: { cassette_name: 'web/files_upload_v2' } do
    it 'completes the upload' do
      client.files_upload_v2(required_params)
    end
  end

  context 'when all options specified', vcr: { cassette_name: 'web/files_upload_v2_with_all_options' } do
    it 'completes the upload' do
      client.files_upload_v2(all_params)
    end
  end
end
