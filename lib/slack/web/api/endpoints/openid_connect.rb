# frozen_string_literal: true
# This file was auto-generated by lib/tasks/web.rake

module Slack
  module Web
    module Api
      module Endpoints
        module OpenidConnect
          #
          # Exchanges a temporary OAuth verifier code for an access token for Sign in with Slack.
          #
          # @option options [string] :client_id
          #   Issued when you created your application.
          # @option options [string] :client_secret
          #   Issued when you created your application.
          # @option options [string] :code
          #   The code param returned via the OAuth callback.
          # @option options [enum] :grant_type
          #   The grant_type param as described in the OAuth spec.
          # @option options [string] :redirect_uri
          #   This must match the originally submitted URI (if one was sent).
          # @option options [string] :refresh_token
          #   The refresh_token param as described in the OAuth spec.
          # @see https://api.slack.com/methods/openid.connect.token
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/openid.connect/openid.connect.token.json
          def openid_connect_token(options = {})
            post('openid.connect.token', options)
          end

          #
          # Get the identity of a user who has authorized Sign in with Slack.
          #
          # @see https://api.slack.com/methods/openid.connect.userInfo
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/openid.connect/openid.connect.userInfo.json
          def openid_connect_userInfo(options = {})
            post('openid.connect.userInfo', options)
          end
        end
      end
    end
  end
end
