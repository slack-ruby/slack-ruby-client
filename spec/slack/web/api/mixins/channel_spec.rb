require 'spec_helper'

RSpec.describe Slack::Web::Api::Mixins::Channel do
  let(:klass) do
    Class.new do
      include Slack::Web::Api::Mixins::Channel
    end
  end
  subject do
    klass.new
  end
  before do
    allow(subject).to receive(:channels_list).and_return(
      'channels' => [{
        'id' => 'CDEADBEEF',
        'name' => 'general'
      }]
    )
  end
  context '#get_channel_id' do
    it 'leaves channels specified by ID alone' do
      expect(subject.get_channel_id('C123456')).to eq 'C123456'
    end
    it 'translates a channel that starts with a #' do
      expect(subject.get_channel_id('#general')).to eq 'CDEADBEEF'
    end
  end
end
