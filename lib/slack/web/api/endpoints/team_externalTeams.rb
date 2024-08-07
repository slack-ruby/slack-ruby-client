# frozen_string_literal: true
# This file was auto-generated by lib/tasks/web.rake

module Slack
  module Web
    module Api
      module Endpoints
        module TeamExternalteams
          #
          # Disconnect an external organization.
          #
          # @option options [Object] :target_team
          #   The team ID of the target team.
          # @see https://api.slack.com/methods/team.externalTeams.disconnect
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/team.externalTeams/team.externalTeams.disconnect.json
          def team_externalTeams_disconnect(options = {})
            raise ArgumentError, 'Required arguments :target_team missing' if options[:target_team].nil?
            post('team.externalTeams.disconnect', options)
          end

          #
          # Returns a list of all the external teams connected and details about the connection.
          #
          # @option options [enum] :connection_status_filter
          #   Status of the connected team.
          # @option options [string] :cursor
          #   Paginate through collections of data by setting parameter to the team_id attribute returned by a previous request's response_metadata. If not provided, the first page of the collection is returned. See pagination for more detail.
          # @option options [integer] :limit
          #   The maximum number of items to return per page.
          # @option options [array] :slack_connect_pref_filter
          #   Filters connected orgs by Slack Connect pref override(s). Value can be: approved_orgs_only allow_sc_file_uploads profile_visibility away_team_sc_invite_permissions accept_sc_invites sc_mpdm_to_private require_sc_channel_for_sc_dm external_awareness_context_bar.
          # @option options [enum] :sort_direction
          #   Direction to sort in asc or desc.
          # @option options [enum] :sort_field
          #   Name of the parameter that we are sorting by.
          # @option options [array] :workspace_filter
          #   Shows connected orgs which are connected on a specified encoded workspace ID.
          # @see https://api.slack.com/methods/team.externalTeams.list
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/team.externalTeams/team.externalTeams.list.json
          def team_externalTeams_list(options = {})
            if block_given?
              Pagination::Cursor.new(self, :team_externalTeams_list, options).each do |page|
                yield page
              end
            else
              post('team.externalTeams.list', options)
            end
          end
        end
      end
    end
  end
end
