# frozen_string_literal: true
require_relative 'slack/version'
require_relative 'slack/logger'
require_relative 'slack/config'

# Messages
require 'hashie'
require_relative 'slack/messages/message'
require_relative 'slack/messages/formatting'

# Web API
require 'faraday'
require 'faraday_middleware'
require 'json'
require 'logger'
begin
  require 'picky'
rescue LoadError # rubocop:disable Lint/HandleExceptions
  # ignore, only used in users_search
end
begin
  require 'openssl'
rescue LoadError # rubocop:disable Lint/HandleExceptions
  # Used in slack/web/config
end
require_relative 'slack/web/config'
require_relative 'slack/web/api/errors/slack_error'
require_relative 'slack/web/api/errors/too_many_requests_error'
require_relative 'slack/web/api/error'
require_relative 'slack/web/api/errors'
require_relative 'slack/web/faraday/response/raise_error'
require_relative 'slack/web/faraday/connection'
require_relative 'slack/web/faraday/request'
require_relative 'slack/web/api/mixins'
require_relative 'slack/web/api/endpoints'
require_relative 'slack/web/pagination/cursor'
require_relative 'slack/web/client'

# RealTime API
require 'active_support'
require 'active_support/core_ext'
require_relative 'slack/real_time/concurrency'
require_relative 'slack/real_time/socket'
require_relative 'slack/real_time/api/message_id'
require_relative 'slack/real_time/api/ping'
require_relative 'slack/real_time/api/message'
require_relative 'slack/real_time/api/typing'
require_relative 'slack/real_time/models'
require_relative 'slack/real_time/stores'
require_relative 'slack/real_time/config'
require_relative 'slack/real_time/client'

# Events API
require_relative 'slack/events/config'
require_relative 'slack/events/request'
