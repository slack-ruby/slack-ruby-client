require 'slack'

RSpec.describe 'integration test', skip: !ENV['SLACK_API_TOKEN'] && 'missing SLACK_API_TOKEN' do
  before do
    Thread.abort_on_exception = true
  end

  let!(:queue) { Queue.new }

  let!(:client) { Slack::RealTime::Client.new(token: ENV['SLACK_API_TOKEN']) }

  let!(:connection) do
    # starts the client in new thread and pushes an item on a queue when connected
    Thread.new do
      client.start! do |driver|
        driver.on(:open) do
          queue.push nil
        end
      end
    end
  end

  before do
    client.on :hello do
      puts "Successfully connected, welcome '#{client.self['name']}' to the '#{client.team['name']}' team at https://#{client.team['domain']}.slack.com."
    end
  end

  def start_server
    # start server and wait for open
    connection
    queue.pop
  end

  def wait_for_server
    connection.join
  end

  def stop_server
    # trigger stop and wait for start! to return
    client.stop!
  end

  after do
    wait_for_server
  end

  context 'client connected' do
    before do
      start_server
    end

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
    end

    start_server
  end
end
