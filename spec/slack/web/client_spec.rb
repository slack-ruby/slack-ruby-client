require 'spec_helper'

RSpec.describe Slack::Web::Client do
  context 'with defaults' do
    let(:client) { Slack::Web::Client.new }
    describe '#initialize' do
      it 'sets user-agent' do
        expect(client.user_agent).to eq Slack::Web::Config.user_agent
        expect(client.user_agent).to include Slack::VERSION
      end
      Slack::Web::Config::ATTRIBUTES.each do |key|
        it "sets #{key}" do
          expect(client.send(key)).to eq Slack::Web::Config.send(key)
        end
      end
    end
  end
  context 'with custom settings' do
    describe '#initialize' do
      Slack::Web::Config::ATTRIBUTES.each do |key|
        context key do
          let(:client) { Slack::Web::Client.new(key => 'custom') }
          it "sets #{key}" do
            expect(client.send(key)).to_not eq Slack::Web::Config.send(key)
            expect(client.send(key)).to eq 'custom'
          end
        end
      end
    end
  end
end
