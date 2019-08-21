# frozen_string_literal: true
RSpec.shared_context 'connected client' do |opts|
  let(:client) { Slack::RealTime::Client.new(opts || {}) }
  let(:ws) { double(Slack::RealTime::Concurrency::Mock::WebSocket) }
  let(:url) do
    if Slack::RealTime.config.store_class == Slack::RealTime::Stores::Store
      'wss://ms173.slack-msgs.com/websocket/lqcUiAvrKTP-uuid='
    else
      'wss://mpmulti-w5tz.slack-msgs.com/websocket/uid'
    end
  end
  let(:socket) { double(Slack::RealTime::Socket, connected?: true) }

  before do
    Slack::RealTime.configure do |config|
      config.concurrency = Slack::RealTime::Concurrency::Mock
      config.store_class = (opts || {})[:store_class] || Slack::RealTime::Stores::Store
    end
    allow(Slack::RealTime::Socket).to(
      receive(:new).with(url, ping: 30, logger: Slack::Logger.default).and_return(socket)
    )
    allow(socket).to receive(:start_sync)
    allow(socket).to receive(:connect!)
    allow(ws).to receive(:on)
    client.start!
  end
end
