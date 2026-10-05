# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Slack::Web::Api::Helpers::Files do
  subject(:client) { Slack::Web::Client.new }

  describe '#files_upload_v2' do
    it 'requires a filename' do
      expect { client.files_upload_v2(content: 'hello') }.to(
        raise_error(ArgumentError, 'required argument :`filename` missing in file (`0`)')
      )
    end

    it 'requires content' do
      expect { client.files_upload_v2(filename: 'hello.txt') }.to(
        raise_error(ArgumentError, 'required argument :`content` missing in file (`0`)')
      )
    end

    it 'identifies the invalid file in a batch' do
      files = [{ filename: 'hello.txt', content: 'hello' }, { content: 'world' }]
      expect { client.files_upload_v2(files: files) }.to(
        raise_error(ArgumentError, 'required argument :`filename` missing in file (`1`)')
      )
    end

    it 'rejects conflicting channel arguments' do
      expect do
        client.files_upload_v2(filename: 'hello.txt', content: 'hello', channel: '#general', channel_id: 'C123456')
      end.to raise_error(ArgumentError, 'only one of :channel, :channels, or :channel_id is required')
    end
  end
end
