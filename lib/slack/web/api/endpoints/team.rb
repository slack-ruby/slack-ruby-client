# frozen_string_literal: true
# This file was auto-generated by lib/tasks/web.rake

module Slack
  module Web
    module Api
      module Endpoints
        module Team
          #
          # Gets the access logs for the current team.
          #
          # @option options [string] :before
          #   End of time range of logs to include in results (inclusive).
          # @option options [string] :cursor
          #   Parameter for pagination. Set cursor equal to the next_cursor attribute returned by the previous request's response_metadata. This parameter is optional, but pagination is mandatory: the default value simply fetches the first "page" of the collection. See pagination for more details.
          # @option options [integer] :limit
          #   The maximum number of items to return. Fewer than the requested number of items may be returned, even if the end of the list hasn't been reached. If specified, result is returned using a cursor-based approach instead of a classic one.
          # @option options [string] :team_id
          #   encoded team id to get logs from, required if org token is used.
          # @see https://api.slack.com/methods/team.accessLogs
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/team/team.accessLogs.json
          def team_accessLogs(options = {})
            if block_given?
              Pagination::Cursor.new(self, :team_accessLogs, options).each do |page|
                yield page
              end
            else
              post('team.accessLogs', options)
            end
          end

          #
          # Gets billable users information for the current team.
          #
          # @option options [string] :cursor
          #   Set cursor to next_cursor returned by previous call, to indicate from where you want to list next page of users list. Default value fetches the first page.
          # @option options [integer] :limit
          #   The maximum number of items to return.
          # @option options [string] :team_id
          #   encoded team id to get the billable information from, required if org token is used.
          # @option options [user] :user
          #   A user to retrieve the billable information for. Defaults to all users.
          # @see https://api.slack.com/methods/team.billableInfo
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/team/team.billableInfo.json
          def team_billableInfo(options = {})
            options = options.merge(user: users_id(options)['user']['id']) if options[:user]
            if block_given?
              Pagination::Cursor.new(self, :team_billableInfo, options).each do |page|
                yield page
              end
            else
              post('team.billableInfo', options)
            end
          end

          #
          # Gets information about the current team.
          #
          # @option options [string] :domain
          #   Query by domain instead of team (only when team is null). This only works for domains in the same enterprise as the querying team token. This also expects the domain to belong to a team and not the enterprise itself.
          # @option options [string] :team
          #   Team to get info about; if omitted, will return information about the current team.
          # @see https://api.slack.com/methods/team.info
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/team/team.info.json
          def team_info(options = {})
            post('team.info', options)
          end

          #
          # Gets the integration logs for the current team.
          #
          # @option options [string] :app_id
          #   Filter logs to this Slack app. Defaults to all logs.
          # @option options [string] :change_type
          #   Filter logs with this change type. Possible values are added, removed, enabled, disabled, and updated. Defaults to all logs.
          # @option options [string] :service_id
          #   Filter logs to this service. Defaults to all logs.
          # @option options [string] :team_id
          #   encoded team id to get logs from, required if org token is used.
          # @option options [user] :user
          #   Filter logs generated by this user's actions. Defaults to all logs.
          # @see https://api.slack.com/methods/team.integrationLogs
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/team/team.integrationLogs.json
          def team_integrationLogs(options = {})
            options = options.merge(user: users_id(options)['user']['id']) if options[:user]
            post('team.integrationLogs', options)
          end
        end
      end
    end
  end
end
