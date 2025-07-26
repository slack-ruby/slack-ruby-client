# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Slack::Web::Faraday::Response::RaiseError do
  subject(:raise_error_obj) { described_class.new(app) }

  let(:app) { proc {} }
  let(:status) { 200 }
  let(:response) { nil }
  let(:body) { {} }
  let(:env) { double status: status, response: response, body: body, success?: true }

  describe '#on_complete' do
    context 'with status of 429' do
      let(:status) { 429 }
      let(:env) do
        env = ::Faraday::Env.from({
                                    request_headers: {
                                      'Authorization' => 'Bearer very-secret-token-12345'
                                    },
                                    response_headers: {
                                      'retry-after' => 10
                                    },
                                    status: status
                                  })

        env[:response] = ::Faraday::Response.new(env)
        env
      end

      it 'raises a TooManyRequestsError' do
        expect { raise_error_obj.on_complete(env) }.to(
          raise_error(Slack::Web::Api::Errors::TooManyRequestsError)
        )
      end

      it 'redacts Authorization token' do
        error = nil
        begin
          raise_error_obj.on_complete(env)
        rescue Slack::Web::Api::Errors::TooManyRequestsError => e
          error = e
        end

        expect(error).not_to be_nil
        expect(error.response.env[:request_headers]['Authorization']).to eq('[REDACTED]')
        expect(error.inspect).not_to include('very-secret-token-12345')
        expect(error.inspect).to include('[REDACTED]')
      end
    end

    context 'with an ok payload in the body' do
      let(:body) { { 'ok' => 'true' } }

      it 'is nil' do
        expect(raise_error_obj.on_complete(env)).to be_nil
      end
    end

    context 'with a single known error in the body' do
      let(:body) do
        {
          'ok' => false,
          'error' => 'already_in_channel',
          'response_metadata' => { 'messages' => [] }
        }
      end

      it 'raises an error of the matching type with the error message' do
        expect { raise_error_obj.on_complete(env) }.to(
          raise_error(Slack::Web::Api::Errors::AlreadyInChannel, 'already_in_channel')
        )
      end
    end

    context 'with a single unknown error in the body' do
      let(:body) do
        {
          'ok' => false,
          'error' => 'unknown_error',
          'response_metadata' => { 'messages' => [] }
        }
      end

      it 'raises a SlackError with the error message' do
        expect { raise_error_obj.on_complete(env) }.to(
          raise_error(Slack::Web::Api::Errors::SlackError, 'unknown_error')
        )
      end
    end

    context 'with multiple errors in the body' do
      let(:body) do
        {
          'ok' => false,
          'errors' => [
            { 'error' => 'already_in_channel' },
            { 'error' => 'something_else_terrible' }
          ]
        }
      end

      it 'raises a SlackError with the concatenated error messages' do
        expect { raise_error_obj.on_complete(env) }.to(
          raise_error(
            Slack::Web::Api::Errors::SlackError,
            'already_in_channel,something_else_terrible'
          )
        )
      end
    end

    context 'with SLACK_API_TOKEN in the request headers' do
      let(:body) do
        {
          'ok' => false,
          'error' => 'test_error'
        }
      end
      let(:env) do
        env = ::Faraday::Env.from({
                                    response_body: body,
                                    request_headers: {
                                      'Authorization' => 'Bearer very-secret-token-12345',
                                      'User-Agent' => 'Test Client'
                                    },
                                    status: status
                                  })

        env[:response] = ::Faraday::Response.new(env)
        env
      end

      it 'redacts the Authorization header in the raised error' do
        error = nil
        begin
          raise_error_obj.on_complete(env)
        rescue Slack::Web::Api::Errors::SlackError => e
          error = e
        end

        expect(error).not_to be_nil
        expect(error.response.env[:request_headers]['Authorization']).to eq('[REDACTED]')
        expect(error.inspect).not_to include('very-secret-token-12345')
        expect(error.inspect).to include('[REDACTED]')
      end

      it 'preserves other headers' do
        error = nil
        begin
          raise_error_obj.on_complete(env)
        rescue Slack::Web::Api::Errors::SlackError => e
          error = e
        end

        expect(error.response.env[:request_headers]['User-Agent']).to eq('Test Client')
      end
    end
  end
end
