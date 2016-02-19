module Slack
  module RealTime
    module Stores
      # Only stores initial information.
      class Starter < Base
        attr_reader :self

        attr_reader :team

        def initialize(attrs)
          @team = Models::Team.new(attrs.team)
          @self = Models::Team.new(attrs.self)
        end

        # The team domain has changed.
        # @see https://api.slack.com/events/team_domain_change
        # @see https://github.com/dblock/slack-api-ref/blob/master/events/team_domain_change.json
        on :team_domain_change do |data|
          team.url = data.url
          team.domain = data.domain
        end

        # The team is being migrated between servers.
        # @see https://api.slack.com/events/team_migration_started
        # @see https://github.com/dblock/slack-api-ref/blob/master/events/team_migration_started.json
        # on :team_migration_started

        # The team billing plan has changed.
        # @see https://api.slack.com/events/team_plan_change
        # @see https://github.com/dblock/slack-api-ref/blob/master/events/team_plan_change.json
        on :team_plan_change do |data|
          team.plan = data.plan
        end

        # A team preference has been updated.
        # @see https://api.slack.com/events/team_pref_change
        # @see https://github.com/dblock/slack-api-ref/blob/master/events/team_pref_change.json
        on :team_pref_change do |data|
          team.prefs ||= {}
          team.prefs[data.name] = data.value
        end

        # Team profile fields have been updated.
        # @see https://api.slack.com/events/team_profile_change
        # @see https://github.com/dblock/slack-api-ref/blob/master/events/team_profile_change.json
        # on :team_profile_change

        # Team profile fields have been deleted.
        # @see https://api.slack.com/events/team_profile_delete
        # @see https://github.com/dblock/slack-api-ref/blob/master/events/team_profile_delete.json
        # on :team_profile_delete

        # Team profile fields have been reordered.
        # @see https://api.slack.com/events/team_profile_reorder
        # @see https://github.com/dblock/slack-api-ref/blob/master/events/team_profile_reorder.json
        # on :team_profile_reorder

        # The team name has changed.
        # @see https://api.slack.com/events/team_rename
        # @see https://github.com/dblock/slack-api-ref/blob/master/events/team_rename.json
        on :team_rename do |data|
          team.name = data.name
        end

        # The team email domain has changed.
        # @see https://api.slack.com/events/email_domain_changed
        # @see https://github.com/dblock/slack-api-ref/blob/master/events/email_domain_changed.json
        on :email_domain_changed do |data|
          team.email_domain = data.email_domain
        end
      end
    end
  end
end
