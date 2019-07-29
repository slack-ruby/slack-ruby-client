# frozen_string_literal: true
# require 'spec_helper'

#
# to re-record a rtm_start fixture run with
# SLACK_API_TOKEN=... CONCURRENCY=faye-websocket rspec spec/slack/real_time/rtm_start_spec.rb
# edit rtm_start.yml and remove the token, fix wss:// path (run specs, fix failures)
#

# RSpec.describe Slack::RealTime::Client, vcr: { cassette_name: 'web/rtm_start' } do
#   it 'connects' do
#     Slack::Web::Client.new.rtm_start(mpim_aware: true)
#   end
# end
