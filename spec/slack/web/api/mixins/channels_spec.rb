require 'spec_helper'

RSpec.describe Slack::Web::Api::Mixins::Channels do
  let(:klass) do
    Class.new do
      include Slack::Web::Api::Mixins::Channels
    end
  end
  subject do
    klass.new
  end
  before do
    allow(subject).to receive(:channels_list).and_return(Slack::Messages::Message.new(
                                                           'channels' => [{
                                                             'id' => 'CDEADBEEF',
                                                             'name' => 'general'
                                                           }]
    ))
  end
  context '#channels_id' do
    it 'leaves channels specified by ID alone' do
      expect(subject.channels_id(channel: 'C123456')).to eq('ok' => true, 'channel' => { 'id' => 'C123456' })
    end
    it 'translates a channel that starts with a #' do
      expect(subject.channels_id(channel: '#general')).to eq('ok' => true, 'channel' => { 'id' => 'CDEADBEEF' })
    end
    it 'fails with an exception' do
      expect { subject.channels_id(channel: '#invalid') }.to raise_error Slack::Web::Api::Errors::SlackError, 'channel_not_found'
    end
  end
end
