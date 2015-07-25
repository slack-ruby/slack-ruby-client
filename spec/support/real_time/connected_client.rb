RSpec.shared_context 'connected client' do
  let(:client) { Slack::RealTime::Client.new }
  let(:ws) { double(Faye::WebSocket::Client) }
  let(:url) { 'wss://ms173.slack-msgs.com/websocket/lqcUiAvrKTP-uuid=' }
  let(:socket) { double(Slack::RealTime::Socket, connected?: true) }
  before do
    allow(EM).to receive(:run).and_yield
    allow(Slack::RealTime::Socket).to receive(:new).with(url).and_return(socket)
    allow(socket).to receive(:connect!).and_yield(ws)
    allow(ws).to receive(:on)
    client.start!
  end
end

