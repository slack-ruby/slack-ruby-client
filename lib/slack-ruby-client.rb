require 'slack/version'
require 'slack/logger'
require 'slack/config'

# Messages
require 'hashie'
require 'slack/messages/message'
require 'slack/messages/formatting'

# Web API
require 'faraday'
require 'faraday_middleware'
require 'json'
require 'logger'
begin
  require 'picky'
rescue LoadError
  # ignore, only used in users_search
end
require 'slack/web/config'
require 'slack/web/api/error'
require 'slack/web/faraday/response/raise_error'
require 'slack/web/faraday/connection'
require 'slack/web/faraday/request'
require 'slack/web/api/mixins'
require 'slack/web/api/endpoints'
require 'slack/web/client'

# RealTime API
require 'active_support'
require 'active_support/core_ext'
require 'slack/real_time/concurrency'
require 'slack/real_time/socket'
require 'slack/real_time/api/message_id'
require 'slack/real_time/api/ping'
require 'slack/real_time/api/message'
require 'slack/real_time/api/typing'
require 'slack/real_time/models'
require 'slack/real_time/stores'
require 'slack/real_time/config'
require 'slack/real_time/client'
