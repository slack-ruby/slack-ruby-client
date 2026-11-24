# frozen_string_literal: true

require_relative 'support'

members = SlackBenchmarks.members(1_000)
channels = Array.new(1_000) { |i| { id: format('C%08d', i), name: "channel-#{i}", is_channel: true } }
auth = JSON.dump(ok: true, url: 'https://example.slack.com/', team: 'Example', user: 'bot', team_id: 'T1', user_id: 'U1')
posted = JSON.dump(ok: true, channel: 'C1', ts: '1.000', message: { text: 'hello', type: 'message' })

client = SlackBenchmarks.client do |env|
  case env.url.path
  when '/api/auth.test' then auth
  when '/api/chat.postMessage' then posted
  when '/api/users.list' then SlackBenchmarks.paginate(env, :members, members)
  when '/api/conversations.list' then SlackBenchmarks.paginate(env, :channels, channels)
  else raise "unexpected request to #{env.url.path}"
  end
end

blocks = Array.new(10) { |i| { type: 'section', text: { type: 'mrkdwn', text: "Block #{i}" } } }

SlackBenchmarks.run('Slack::Web::Client') do |x|
  x.report('auth_test') { client.auth_test }
  x.report('chat_postMessage with blocks') { client.chat_postMessage(channel: 'C1', text: 'hello', blocks: blocks) }
  x.report('users_list, 10 pages of 100') { client.users_list(limit: 100) { |_page| nil } }
  x.report('users_id, last of 1000') { client.users_id(user: '@user999') }
  x.report('conversations_id, last of 1000') { client.conversations_id(channel: '#channel-999') }
end
