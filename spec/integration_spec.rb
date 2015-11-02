require 'slack'
require 'pry'

Slack.config.token = ENV['SLACK_API_TOKEN']

Thread.abort_on_exception = true

RSpec.describe 'integration test', skip: !Slack.config.token && 'missing SLACK_API_TOKEN' do

  let(:client) { Slack::RealTime::Client.new }

  let(:connection) do
    # starts the client in new fiber and returns back when it connects to the server
    Fiber.new do
      client.start! do |driver|
        driver.on(:open) { Fiber.yield }
      end
      Fiber.yield
    end
  end

  before do
    client.on :hello do
      puts "Successfully connected, welcome '#{client.self['name']}' to the '#{client.team['name']}' team at https://#{client.team['domain']}.slack.com."
    end
  end

  def start_server
    # start server and wait for open
    connection.resume
  end

  def wait_for_server
    connection.resume
  end

  def stop_server
    # trigger stop and wait for start! to return
    client.stop!
  end

  after { wait_for_server }

  context 'client connected' do
    before { start_server }

    it do
      message = SecureRandom.hex

      client.on(:message) do |data|
        expect(data).to include('text' => message, 'subtype' => 'bot_message')
        client.stop!
      end

      client.web_client.chat_postMessage channel: "@#{client.self['name']}", text: message
    end
  end


  it 'gets hello' do
    client.on(:hello) do
      client.stop!
      puts 'client stopped'
    end

    start_server
  end
end
