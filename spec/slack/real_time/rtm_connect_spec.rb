# frozen_string_literal: true
# require 'spec_helper'

#
# to re-record a rtm_connect fixture run with
# SLACK_API_TOKEN=... CONCURRENCY=faye-websocket rspec spec/slack/real_time/rtm_connect_spec.rb
# edit rtm_connect.yml and remove the token, fix wss:// path (run specs, fix failures)
#

# RSpec.describe Slack::RealTime::Client, vcr: { cassette_name: 'web/rtm_connect' } do
#   it 'connects' do
#     Slack::Web::Client.new.rtm_connect(mpim_aware: true)
#   end
# end
