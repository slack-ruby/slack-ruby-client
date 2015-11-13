RSpec.shared_context 'connected client' do
  let(:client) { Slack::RealTime::Client.new }
  let(:ws) { double(Slack::RealTime::Concurrency::Mock::WebSocket) }
  let(:url) { 'wss://ms173.slack-msgs.com/websocket/lqcUiAvrKTP-uuid=' }
  let(:socket) { double(Slack::RealTime::Socket, connected?: true) }
  before do
    Slack::RealTime.configure do |config|
      config.concurrency = Slack::RealTime::Concurrency::Mock
    end
    allow(Slack::RealTime::Socket).to receive(:new).with(url, ping: 30).and_return(socket)
    allow(socket).to receive(:connect!).and_yield(ws)
    allow(ws).to receive(:on)
    client.start!
  end
end
