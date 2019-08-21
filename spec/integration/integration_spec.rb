# frozen_string_literal: true
require 'spec_helper'

RSpec.describe 'integration test', skip: ( # rubocop:disable RSpec/DescribeClass
  (!ENV['SLACK_API_TOKEN'] || !ENV['CONCURRENCY']) && 'missing SLACK_API_TOKEN and/or CONCURRENCY'
) do
  around do |ex|
    WebMock.allow_net_connect!
    VCR.turned_off { ex.run }
    WebMock.disable_net_connect!
  end

  let(:client) { Slack::RealTime::Client.new(token: ENV['SLACK_API_TOKEN']) }
  let(:logger) do
    logger = Logger.new(STDOUT)
    logger.level = Logger::INFO
    logger
  end
  let!(:queue) { @queue = QueueWithTimeout.new }

  before do
    Thread.abort_on_exception = true

    Slack.configure do |slack|
      slack.logger = logger
    end

    client.on :hello do
      logger.info(
        "Successfully connected, welcome '#{client.self.name}' to " \
        "the '#{client.team.name}' team at https://#{client.team.domain}.slack.com."
      )
    end

    client.on :message do |event|
      logger.info " #{event.class}"
    end

    client.on :close do
      logger.info 'Disconnecting ...'
      # pushes another item to the queue when disconnected
      queue.push :closed
    end
  end

  after do
    Slack.config.reset
    wait_for_server # wait for :closed to be pushed on queue
    @server.join if @server.is_a?(::Thread)
  end

  def start_server
    dt = rand(10..20)
    logger.debug "#start_server, waiting #{dt} second(s)"
    sleep dt # prevent Slack 429 rate limit errors
    # starts the client and pushes an item on a queue when connected
    @server = client.start_async do |driver|
      driver.on :open do |data|
        logger.debug "connection.on :open, data=#{data}"
        queue.push :opened
      end

      driver.on :hello do |data|
        logger.debug "connection.on :hello, data=#{data}"
      end
    end
    logger.debug "started #{@server}"
    expect(queue.pop_with_timeout(5)).to eq :opened
  end

  def wait_for_server
    return unless @queue

    logger.debug '#wait_for_server'
    queue.pop_with_timeout(5)
    logger.debug '#wait_for_server, joined'
    @queue = nil
  end

  context 'client connected' do
    let(:channel) { "@#{client.self.id}" }
    let(:message) { SecureRandom.hex }

    it 'responds to message' do
      client.on :message do |data|
        logger.debug data
        # concurrent execution of tests causes messages to arrive in any order
        next unless data.text == message

        expect(data.text).to eq message
        expect(data.subtype).to eq 'bot_message'
        logger.debug 'client.stop!'
        expect(client.started?).to be true
        client.stop!
      end

      start_server

      logger.debug "chat_postMessage, channel=#{channel}, message=#{message}"
      client.web_client.chat_postMessage channel: channel, text: message
    end

    it 'sends message' do
      client.on :hello do
        expect(client.message(channel: channel, text: message)).to be true
        client.stop!
      end

      start_server
    end
  end

  it 'gets hello' do
    client.on :hello do |data|
      logger.debug "client.on :hello, data=#{data}"
      expect(client.started?).to be true
      client.stop!
    end

    start_server
  end

  context 'with websocket_ping set' do
    before do
      client.websocket_ping = 5
    end

    it 'sends pings' do
      @reply_to = nil
      client.on :pong do |data|
        @reply_to = data.reply_to
        queue.push :pong
        client.stop!
      end

      start_server

      queue.pop_with_timeout(10)
      expect(@reply_to).to eq 1
    end

    it 'rebuilds the websocket connection when dropped' do
      @reply_to = nil
      client.on :pong do |data|
        logger.info data
        @reply_to = data.reply_to
        if @reply_to == 1
          client.instance_variable_get(:@socket).close
          queue.push :close
        else
          expect(@reply_to).to eq 2
          queue.push :pong
          client.stop!
        end
      end

      start_server

      4.times do |i|
        queue.pop_with_timeout(10)
        client.logger.info "Pop #{i}"
      end
    end
  end

  context 'with websocket_ping not set' do
    before do
      client.websocket_ping = 0
    end

    it 'does not send pings' do
      @reply_to = nil

      client.on :pong do |data|
        @reply_to = data.reply_to
      end

      client.on :hello do
        client.stop!
      end

      start_server
      wait_for_server

      expect(@reply_to).to be nil
    end
  end

  it 'gets close, followed by closed' do
    client.on :hello do
      expect(client.started?).to be true
      client.stop!
    end

    client.on :close do |data|
      logger.debug "client.on :close, data=#{data}"
      @close_called = true
    end

    client.on :closed do |data|
      logger.debug "client.on :closed, data=#{data}"
      expect(@close_called).to be true
    end

    start_server
  end
end
