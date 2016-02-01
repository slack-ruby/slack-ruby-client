require 'spec_helper'

describe Slack do
  let(:slack) { File.expand_path(File.join(__FILE__, '../../../bin/slack')) }
  before do
    @token = ENV.delete('SLACK_API_TOKEN')
  end
  after do
    ENV['SLACK_API_TOKEN'] = @token if @token
  end
  describe '#help' do
    it 'displays help' do
      help = `"#{slack}" help`
      expect(help).to include 'slack - Slack client.'
    end
  end
  context 'globals' do
    it 'enables request and response logging with -d' do
      output = `"#{slack}" --vcr-cassette-name=web/auth_test_success --slack-api-token=token -d auth test 2>&1`
      expect(output).to include 'post https://slack.com/api/auth.test'
      expect(output).to include 'Status: 200'
    end
    it 'requires --slack-api-token' do
      err = `"#{slack}" auth test 2>&1`
      expect(err).to start_with 'error: parse error: Set Slack API token via --slack-api-token or SLACK_API_TOKEN.'
    end
  end
  describe '#auth' do
    context 'bad auth' do
      it 'fails with an exception' do
        err = `"#{slack}" --vcr-cassette-name=web/auth_test_error --slack-api-token=token auth test 2>&1`
        expect(err).to eq "error: not_authed\n"
      end
    end
    context 'good auth' do
      it 'succeeds' do
        json = Slack::Messages::Message.new(JSON.parse(`"#{slack}" --vcr-cassette-name=web/auth_test_success --slack-api-token=token auth test 2>&1`))
        expect(json).to eq(
          'ok' => true,
          'url' => 'https://rubybot.slack.com/',
          'team' => 'team_name',
          'user' => 'user_name',
          'team_id' => 'TDEADBEEF',
          'user_id' => 'UBAADFOOD'
        )
        expect(json.ok).to be true
      end
    end
  end
  describe '#users' do
    it 'list' do
      json = Slack::Messages::Message.new(JSON.parse(`"#{slack}" --vcr-cassette-name=web/users_list --slack-api-token=token users list --presence=true 2>&1`))
      expect(json.ok).to be true
      expect(json.members.size).to eq 9
      expect(json.members.first['presence']).to eq 'away'
    end
  end
end
