# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Slack::Web::Api::Error do
  let(:client) { Slack::Web::Client.new }

  describe '#encode_options_as_json' do
    let(:encoded_options) { client.encode_options_as_json(options, keys) }

    let(:keys) { %i[attachments blocks metadata] }

    context 'with some of the keys present in the options' do
      let(:options) do
        {
          text: 'Hello, world!',
          blocks: blocks,
          metadata: metadata
        }
      end

      context 'and non-string objects in those keys' do
        let(:blocks) { [{ type: 'section' }, { type: 'actions' }] }
        let(:metadata) { { external_id: SecureRandom.uuid } }

        it 'encodes the named keys into json' do
          expect(encoded_options).to eql(
            text: 'Hello, world!',
            blocks: JSON.dump(blocks),
            metadata: JSON.dump(metadata)
          )
        end
      end

      context 'and string objects in those keys' do
        let(:blocks) { JSON.dump([{ type: 'section' }, { type: 'actions' }]) }
        let(:metadata) { JSON.dump({ external_id: SecureRandom.uuid }) }

        it 'returns the original options' do
          expect(encoded_options).to eql(options)
        end
      end
    end

    context 'with none of the keys present in the options' do
      let(:options) do
        {
          text: 'Hello, world!'
        }
      end

      it 'returns the original options' do
        expect(encoded_options).to eql(options)
      end
    end

    context 'with no keys given' do
      let(:options) do
        {
          text: 'Hello, world!'
        }
      end
      let(:keys) { [] }

      it 'returns the original options' do
        expect(encoded_options).to eql(options)
      end
    end
  end
end
