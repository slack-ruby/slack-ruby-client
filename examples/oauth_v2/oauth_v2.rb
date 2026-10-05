#!/usr/bin/env ruby
# frozen_string_literal: true

require 'dotenv/load'
require 'webrick'
require 'slack-ruby-client'
require 'active_support'
require 'active_support/core_ext/object/to_query'

server = WEBrick::HTTPServer.new(Port: ENV['PORT'] || 4242)

trap 'INT' do
  server.shutdown
end

server.mount_proc '/' do |req, res|
  client = Slack::Web::Client.new

  response = client.oauth_v2_access(
    req.query.merge(
      client_id: ENV.fetch('SLACK_CLIENT_ID', nil),
      client_secret: ENV.fetch('SLACK_CLIENT_SECRET', nil),
      grant_type: 'authorization_code'
    )
  )

  pp response

  res.body = %(
<html>
  <body>
    <ul>
      <li>bot access_token: #{response.access_token}</li>
      <li>token_type: #{response.token_type}</li>
      <li>app_id: #{response.app_id}</li>
      <li>scope: #{response.scope}</li>
      <li>user: #{response.authed_user.id}</li>
      <li>user access token: #{response.authed_user.access_token}</li>
    </ul>
  <body>
</html>
  )

  pp Slack::Web::Client.new(token: response.authed_user.access_token || response.access_token).auth_test

  server.shutdown
end

query = {
  client_id: ENV.fetch('SLACK_CLIENT_ID', nil),
  redirect_uri: ENV.fetch('REDIRECT_URI', nil),
  scope: ENV.fetch('SCOPE', nil),
  user_scope: ENV.fetch('USER_SCOPE', nil)
}

url = "https://slack.com/oauth/v2/authorize?#{query.to_query}"
puts "Opening browser at #{url}."
system 'open', url

server.start
