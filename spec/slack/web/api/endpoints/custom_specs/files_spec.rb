# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Slack::Web::Api::Endpoints::Files do
  let(:client) { Slack::Web::Client.new }

  %w[filename content].each do |arg|
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
          client.files_upload_v2(params)
        end.to raise_error ArgumentError, /Required argument :#{arg} missing/
      end
    end
  end

  context 'without a channel', vcr: { cassette_name: 'web/files_upload_v2' } do
    it 'completes the upload' do
      expect(client.files_upload_v2(
        filename: 'test.txt',
        content: 'Test File Contents'
      ).files.size).to eq 1
    end
  end

  %i[channel channels channel_id].permutation(2).map(&:sort).uniq.each do |permutation|
    it "requires only one of #{permutation.join(' or ')}" do
      expect do
        client.files_upload_v2({
          filename: 'test.txt',
          content: 'Test File Contents'
        }.merge(permutation.map { |arg| [arg, 'C08AZ76CA4V'] }.to_h))
      end.to raise_error ArgumentError, 'Only one of :channel, :channels, or :channel_id is required'
    end
  end

  it 'requires only one of :channels, or :channel_id' do
    expect do
      client.files_upload_v2(
        filename: 'test.txt',
        content: 'Test File Contents',
        channels: 'C08AZ76CA4V',
        channel_id: 'C08AZ76CA4V'
      )
    end.to raise_error ArgumentError, 'Only one of :channel, :channels, or :channel_id is required'
  end

  %i[channel channel_id channels].each do |arg|
    it "completes the upload with #{arg}", vcr: { cassette_name: "web/files_upload_v2_#{arg}" } do
      expect(client.files_upload_v2(
        filename: 'test.txt',
        content: 'Test File Contents',
        arg => 'C08AZ76CA4V'
      ).files.size).to eq 1
    end

    context 'when a channel is referenced by name', vcr: { cassette_name: "web/files_upload_v2_with_channel_name_#{arg}" } do
      before do
        allow(client).to receive(:conversations_list).and_yield(
          Slack::Messages::Message.new(
            'channels' => [{
              'id' => 'C08AZ76CA4V',
              'name' => 'general'
            }]
          )
        )
      end

      it "translates the channel name to an ID and completes the upload with #{arg}" do
        expect(client.files_upload_v2(
          filename: 'test.txt',
          content: 'Test File Contents',
          arg => '#general'
        ).files.size).to eq 1
      end
    end
  end

  context 'when using a list for channels', vcr: { cassette_name: 'web/files_upload_v2_with_channels_list' } do
    it 'completes the upload' do
      expect(client.files_upload_v2(
        filename: 'test.txt',
        content: 'Test File Contents',
        channels: 'C08AZ76CA4V,C08BHPZBZ8A'
      ).files.size).to eq 1
    end
  end

  context 'when all options specified', vcr: { cassette_name: 'web/files_upload_v2_with_all_options' } do
    it 'completes the upload' do
      expect(client.files_upload_v2(
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

  context 'with an array of channels', vcr: { cassette_name: 'web/files_upload_v2_with_channels_list' } do
    before do
      allow(client).to receive(:conversations_list).and_yield(
        Slack::Messages::Message.new(
          'channels' => [{
            'id' => 'C08BHPZBZ8A',
            'name' => 'general'
          }]
        )
      )
    end

    it 'completes the upload' do
      expect(client.files_upload_v2(
        filename: 'test.txt',
        content: 'Test File Contents',
        channels: ['C08AZ76CA4V', '#general']
      ).files.size).to eq 1
    end
  end
end
