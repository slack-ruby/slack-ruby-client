# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Slack::Web::Api::Endpoints::Files do
  let(:client) { Slack::Web::Client.new }

  %w[filename channels content].each do |arg|
    context "when #{arg} is missing from options" do
      let(:params) do
        {
          filename: 'test.txt',
          content: 'Test File Contents',
          channels: 'C08AZ76CA4V'
        }
      end

      before do
        params.delete(arg.to_sym)
      end

      it 'raises an argument error' do
        expect do
          client.files_upload_external(params)
        end.to raise_error ArgumentError, /Required argument :#{arg} missing/
      end
    end
  end

  context 'when all required options are sent', vcr: { cassette_name: 'web/files_upload_external' } do
    it 'completes the upload' do
      expect(client.files_upload_external(
        filename: 'test.txt',
        content: 'Test File Contents',
        channels: 'C08AZ76CA4V'
      ).files.size).to eq 1
    end
  end

  context 'when using a list for channels', vcr: { cassette_name: 'web/files_upload_external_with_channels_list' } do
    it 'completes the upload' do
      expect(client.files_upload_external(
        filename: 'test.txt',
        content: 'Test File Contents',
        channels: 'C08AZ76CA4V,C08BHPZBZ8A'
      ).files.size).to eq 1
    end
  end

  context 'when all options specified', vcr: { cassette_name: 'web/files_upload_external_with_all_options' } do
    it 'completes the upload' do
      expect(client.files_upload_external(
        title: 'title',
        filename: 'test.txt',
        content: 'Test File Contents',
        channels: 'C08AZ76CA4V',
        initial_comment: 'initial_comment',
        thread_ts: '1738331914.958599',
        snippet_type: 'text'
      ).files.size).to eq 1
    end
  end
end
