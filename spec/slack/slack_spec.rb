# frozen_string_literal: true
require 'spec_helper'
require 'open3'

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

  context 'without gli installed' do
    # --disable-gems (and no inherited bundler setup) leaves gli unloadable on every Ruby.
    let(:env) { { 'RUBYOPT' => nil, 'RUBYLIB' => nil, 'BUNDLE_GEMFILE' => nil, 'BUNDLE_BIN_PATH' => nil } }

    it 'exits with instructions to install it' do
      output, status = Open3.capture2e(env, RbConfig.ruby, '--disable-gems', slack, 'help')
      expect(status.exitstatus).to eq 1
      expect(output).to include "The slack command-line client requires the gli gem. Add `gem 'gli'` to your Gemfile"
    end
  end

  context 'globals' do
    let(:command) do
      "\"#{slack}\" --vcr-cassette-name=web/auth_test_success " \
        '--slack-api-token=token -d auth test 2>&1'
    end

    it 'enables request and response logging with -d' do
      output = `#{command}`
      expect(output).to include 'POST https://slack.com/api/auth.test'
      expect(output).to include 'Status 200'
    end

    it 'requires --slack-api-token' do
      err = `"#{slack}" auth test 2>&1`
      expect(err).to(
        start_with(
          'error: parse error: Set Slack API token via --slack-api-token or SLACK_API_TOKEN.'
        )
      )
    end
  end

  describe '#auth' do
    context 'bad auth' do
      let(:command) do
        "\"#{slack}\" --vcr-cassette-name=web/auth_test_error " \
          '--slack-api-token=token auth test 2>&1'
      end

      it 'fails with an exception' do
        err = `#{command}`
        expect(err).to eq "error: not_authed\n"
      end
    end

    context 'good auth' do
      let(:command) do
        "\"#{slack}\" --vcr-cassette-name=web/auth_test_success " \
          '--slack-api-token=token auth test 2>&1'
      end

      it 'succeeds' do
        json = Slack::Messages::Message.new(JSON[`#{command}`])
        expect(json).to eq(
          'bot_id' => 'B0J1L75DY',
          'is_enterprise_install' => false,
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
    let(:command) do
      "\"#{slack}\" --vcr-cassette-name=web/users_list " \
        '--slack-api-token=token users list --presence=true 2>&1'
    end

    it 'list' do
      json = Slack::Messages::Message.new(JSON[`#{command}`])
      expect(json.ok).to be true
      expect(json.members.size).to eq 35
      expect(json.members.first['presence']).to eq 'away'
    end
  end
end
