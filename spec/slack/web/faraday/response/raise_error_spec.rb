require 'spec_helper'

RSpec.describe Slack::Web::Faraday::Response::RaiseError do
  describe '#on_complete' do
    let(:subject) { described_class.new }
    let(:status) { 200 }
    let(:response) { nil }
    let(:body) { {} }
    let(:env) { double status: status, response: response, body: body }

    context 'with status of 429' do
      let(:status) { 429 }

      it 'raises a TooManyRequestsError' do
        expect { subject.on_complete(env) }.to raise_error(Slack::Web::Api::Errors::TooManyRequestsError)
      end
    end

    context 'with an ok payload in the body' do
      let(:body) { { 'ok' => 'true' } }

      it 'is nil' do
        expect(subject.on_complete(env)).to eq nil
      end
    end

    context 'with a single error in the body' do
      let(:body) { { 'error' => 'already_in_channel' } }

      it 'raises a SlackError with the error message' do
        expect { subject.on_complete(env) }.to raise_error(Slack::Web::Api::Errors::SlackError, 'already_in_channel')
      end
    end

    context 'with multiple errors in the body' do
      let(:body) do
        {
          'errors' => [
            { 'error' => 'already_in_channel' },
            { 'error' => 'something_else_terrible' }
          ]
        }
      end

      it 'raises a SlackError with the concatenated error messages' do
        expect { subject.on_complete(env) }.to raise_error(Slack::Web::Api::Errors::SlackError, 'already_in_channel,something_else_terrible')
      end
    end
  end
end
