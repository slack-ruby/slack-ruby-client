# frozen_string_literal: true
require 'spec_helper'
require 'rack'
require 'rack/lint'
require 'rack/rewindable_input'
require 'rackup/handler/webrick'

RSpec.describe Slack::Events::Request do
  let(:signing_secret) { 'test-signing-secret' }
  let(:timestamp) { Time.now.to_i.to_s }
  let(:body) { '{"type":"url_verification","challenge":"hello"}' }
  let(:signature) do
    "v0=#{OpenSSL::HMAC.hexdigest('SHA256', signing_secret, "v0:#{timestamp}:#{body}")}"
  end
  let(:consume_body) { false }
  let(:buffer_body) { false }
  let(:observed_inputs) { [] }
  let(:app) do
    Rack::Lint.new(lambda do |env|
      observed_inputs << env.fetch('rack.input')
      env['rack.input'] = Rack::RewindableInput.new(env['rack.input']) if buffer_body
      env['rack.input'].read if consume_body
      slack_request = described_class.new(Rack::Request.new(env), signing_secret: signing_secret)
      begin
        slack_request.verify!
        [200, { 'content-type' => 'application/json' }, [slack_request.body, slack_request.body]]
      rescue Slack::Events::Request::InvalidSignature
        [401, { 'content-type' => 'text/plain' }, ['invalid signature']]
      ensure
        env['rack.input'].close if buffer_body
      end
    end)
  end
  let(:server) { WEBrick::HTTPServer.new(DoNotListen: true, Logger: WEBrick::Log.new(File::NULL), AccessLog: []) }

  def http_request
    raw_request = [
      'POST /events HTTP/1.1',
      'Host: localhost',
      'Content-Type: application/json',
      "Content-Length: #{body.bytesize}",
      "X-Slack-Request-Timestamp: #{timestamp}",
      "X-Slack-Signature: #{signature}",
      '', body
    ].join("\r\n")
    WEBrick::HTTPRequest.new(server.config).tap { |request| request.parse(StringIO.new(raw_request)) }
  end

  after do
    server.shutdown
  end

  def dispatch
    response = WEBrick::HTTPResponse.new(server.config)
    Rackup::Handler::WEBrick.new(server, app).service(http_request, response)
    response
  end

  it 'verifies a signed WEBrick request and caches its complete body' do
    http_response = dispatch
    expect(http_response.status).to eq 200
    expect(http_response.body).to eq body * 2
    expect(observed_inputs.first).not_to respond_to(:rewind)
  end

  context 'with an invalid signature' do
    let(:signature) { 'v0=invalid' }

    it 'rejects the request' do
      http_response = dispatch
      expect(http_response.status).to eq 401
    end
  end

  context 'with input already read by another consumer' do
    let(:consume_body) { true }

    it 'rejects the request because the full body cannot be recovered' do
      http_response = dispatch
      expect(http_response.status).to eq 401
    end

    context 'with input buffering before the first consumer' do
      let(:buffer_body) { true }

      it 'verifies the request and preserves the full body' do
        http_response = dispatch
        expect(http_response.status).to eq 200
        expect(http_response.body).to eq body * 2
      end
    end
  end
end
