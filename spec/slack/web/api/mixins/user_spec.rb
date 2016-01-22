require 'spec_helper'

RSpec.describe Slack::Web::Api::Mixins::User do
  let(:klass) do
    Class.new do
      include Slack::Web::Api::Mixins::User
    end
  end
  subject do
    klass.new
  end
  before do
    allow(subject).to receive(:users_list).and_return(
      'members' => [{
        'id' => 'UDEADBEEF',
        'name' => 'aws'
      }]
    )
  end
  context '#get_user_id' do
    it 'leaves users specified by ID alone' do
      expect(subject.get_user_id('U123456')).to eq 'U123456'
    end
    it 'translates a user that starts with a #' do
      expect(subject.get_user_id('@aws')).to eq 'UDEADBEEF'
    end
  end
end
