require 'spec_helper'

RSpec.describe Slack::Web::Api::Mixins::Groups do
  let(:klass) do
    Class.new do
      include Slack::Web::Api::Mixins::Groups
    end
  end
  subject do
    klass.new
  end
  before do
    allow(subject).to receive(:groups_list).and_return(Slack::Messages::Message.new(
                                                         'groups' => [{
                                                           'id' => 'CDEADBEEF',
                                                           'name' => 'general'
                                                         }]
    ))
  end
  context '#groups_id' do
    it 'leaves groups specified by ID alone' do
      expect(subject.groups_id(channel: 'C123456')).to eq('ok' => true, 'group' => { 'id' => 'C123456' })
    end
    it 'translates a channel that starts with a #' do
      expect(subject.groups_id(channel: '#general')).to eq('ok' => true, 'group' => { 'id' => 'CDEADBEEF' })
    end
    it 'fails with an exception' do
      expect { subject.groups_id(channel: '#invalid') }.to raise_error Slack::Web::Api::Errors::SlackError, 'channel_not_found'
    end
  end
end
