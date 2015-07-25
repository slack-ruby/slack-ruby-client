require 'slack/version'
require 'slack/config'

# Web API
require 'faraday'
require 'faraday_middleware'
require 'slack/web/config'
require 'slack/web/api/error'
require 'slack/web/faraday/response/raise_error'
require 'slack/web/faraday/connection'
require 'slack/web/faraday/request'
require 'slack/web/api/endpoints'
require 'slack/web/client'

# RealTime API
require 'faye/websocket'
require 'eventmachine'
require 'slack/real_time/socket'
require 'slack/real_time/api/message_id'
require 'slack/real_time/api/ping'
require 'slack/real_time/api/message'
require 'slack/real_time/api/typing'
require 'slack/real_time/client'
