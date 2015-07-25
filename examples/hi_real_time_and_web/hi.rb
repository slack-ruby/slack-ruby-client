require 'slack-ruby-client'

Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
  fail 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
end

client = Slack::RealTime::Client.new

client.on :hello do
  puts 'Successfully connected.'
end

client.on :message do |data|
  puts data
  case data['text']
  when 'bot hi' then
    client.web_client.chat_postMessage channel: data['channel'], text: "Hi <@#{data['user']}>!"
  when /^bot/ then
    client.web_client.chat_postMessage channel: data['channel'], text: "Sorry <@#{data['user']}>, what?"
  end
end

client.start!
