# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Slack::Web::Api::Endpoints::Dialog do
  let(:client) { Slack::Web::Client.new }

  context 'dialog_open' do
    it 'automatically converts dialog into JSON' do
      expect(client).to receive(:post).with(
        'dialog.open',
        trigger_id: '12345.98765.abcd2358fdea',
        dialog: '[]'
      )
      client.dialog_open(trigger_id: '12345.98765.abcd2358fdea', dialog: [])
    end

    context 'arguments' do
      it 'requires dialog' do
        expect { client.dialog_open(trigger_id: '123') }.to(
          raise_error(ArgumentError, /Required arguments :dialog missing/)
        )
      end
      it 'requires trigger_id' do
        expect { client.dialog_open(dialog: []) }.to(
          raise_error(ArgumentError, /Required arguments :trigger_id missing/)
        )
      end
      it 'likes both dialog and trigger_id' do
        expect(client).to(
          receive(:post).with('dialog.open', hash_including(trigger_id: '123', dialog: '[]'))
        )
        expect { client.dialog_open(dialog: [], trigger_id: '123') }.not_to raise_error
      end
    end
  end
end
