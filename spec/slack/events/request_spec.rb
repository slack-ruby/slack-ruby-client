# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Slack::Events::Request do
  subject(:request) do
    described_class.new(http_request)
  end

  before do
    Slack::Events.configure do |config|
      config.signing_secret = signing_secret
      config.signature_expires_in = 30
    end
  end

  let(:signing_secret) { 'ade6ca762ade4db0e7d31484cd616b9c' }
  let(:signature) { 'v0=91177eea054d65de0fc0f9b4ec57714307bc0ce2c5f3bf0d28b1b720c8f92ba2' }
  let(:timestamp) { '1547933148' }
  let(:body) do
    '{"token":"X34FAqCu8tmGEkEEpoDncnja","challenge":' \
    '"P7sFXA4o3HV2hTx4zb4zcQ9yrvuQs8pDh6EacOxmMRj0tJaXfQFF","type":"url_verification"}'
  end
  let(:http_request) do
    double(
      headers: {
        'X-Slack-Request-Timestamp' => timestamp,
        'X-Slack-Signature' => signature
      },
      body: double(
        read: body
      )
    )
  end

  after do
    Slack::Events.config.reset
  end

  it 'reads http request' do
    expect(request.signature).to eq signature
    expect(request.body).to eq body
    expect(request.timestamp).to eq timestamp
    expect(request.version).to eq 'v0'
  end
  context 'time' do
    after do
      Timecop.return
    end

    context 'with an invalid signature' do
      let(:signature) { 'v0=invalid' }

      before do
        Timecop.freeze(Time.at(timestamp.to_i))
      end

      it 'is invalid but not expired' do
        expect(request).not_to be_valid
        expect(request).not_to be_expired
      end
    end

    context 'with an invalid body' do
      let(:body) { 'invalid' }

      before do
        Timecop.freeze(Time.at(timestamp.to_i))
      end

      it 'is invalid but not expired' do
        expect(request).not_to be_valid
        expect(request).not_to be_expired
      end
    end

    context 'with an invalid signing secret' do
      before do
        Slack::Events.configure do |config|
          config.signing_secret = 'invalid'
        end
        Timecop.freeze(Time.at(timestamp.to_i))
      end

      it 'is invalid but not expired' do
        expect(request).not_to be_valid
        expect(request).not_to be_expired
      end
    end

    context 'within time window' do
      before do
        Timecop.freeze(Time.at(timestamp.to_i) + Slack::Events.config.signature_expires_in - 1)
      end

      it 'is valid' do
        expect(request).to be_valid
        expect(request).not_to be_expired
      end
      it 'does not raise an error and returns true' do
        expect(request.verify!).to be true
      end
    end

    context 'after time window' do
      before do
        Timecop.freeze(Time.at(timestamp.to_i) + Slack::Events.config.signature_expires_in + 1)
      end

      it 'is valid but expired' do
        expect(request).to be_valid
        expect(request).to be_expired
      end
      it 'raises an error on verify!' do
        expect { request.verify! }.to raise_error Slack::Events::Request::TimestampExpired
      end
    end

    context 'before time but within window' do
      before do
        Timecop.freeze(Time.at(timestamp.to_i) - Slack::Events.config.signature_expires_in + 1)
      end

      it 'is valid and not expired' do
        expect(request).to be_valid
        expect(request).not_to be_expired
      end
      it 'does not raise an error on verify!' do
        expect(request.verify!).to be true
      end
    end

    context 'before time window' do
      before do
        Timecop.freeze(Time.at(timestamp.to_i) - Slack::Events.config.signature_expires_in - 1)
      end

      it 'is valid but expired' do
        expect(request).to be_valid
        expect(request).to be_expired
      end
      it 'raises an error on verify!' do
        expect { request.verify! }.to raise_error Slack::Events::Request::TimestampExpired
      end
    end
  end

  context 'without global config' do
    before do
      Slack::Events.config.reset
    end

    context 'without a signing secret parameter' do
      subject(:request) do
        described_class.new(http_request)
      end

      it 'raises MissingSigningSecret' do
        expect { request.valid? }.to raise_error Slack::Events::Request::MissingSigningSecret
      end
    end

    context 'with a signing secret parameter' do
      subject(:request) do
        described_class.new(http_request,
                            signing_secret: signing_secret,
                            signature_expires_in: 30)
      end

      before do
        Timecop.freeze(Time.at(timestamp.to_i))
      end

      it 'is valid and not expired' do
        expect(request).to be_valid
        expect(request).not_to be_expired
      end
    end
  end
end
