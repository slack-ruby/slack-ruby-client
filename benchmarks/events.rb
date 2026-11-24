# frozen_string_literal: true

require_relative 'support'
require 'rack'
require 'stringio'

secret = 'benchmark-signing-secret'
body = JSON.dump(token: 'x', team_id: 'T1', event: { type: 'message', text: 'hello' * 50 })

def signed_env(secret, body)
  timestamp = Time.now.to_i.to_s
  hex = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('SHA256'), secret, "v0:#{timestamp}:#{body}")
  Rack::MockRequest.env_for(
    '/events', method: 'POST', input: body,
               'HTTP_X_SLACK_REQUEST_TIMESTAMP' => timestamp, 'HTTP_X_SLACK_SIGNATURE' => "v0=#{hex}"
  )
end

env = signed_env(secret, body)

SlackBenchmarks.run('Slack::Events::Request') do |x|
  x.report('verify!') do
    env['rack.input'].rewind
    Slack::Events::Request.new(Rack::Request.new(env), signing_secret: secret).verify!
  end
end
