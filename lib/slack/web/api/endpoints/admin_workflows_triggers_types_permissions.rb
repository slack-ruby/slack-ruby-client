# frozen_string_literal: true
# This file was auto-generated by lib/tasks/web.rake

module Slack
  module Web
    module Api
      module Endpoints
        module AdminWorkflowsTriggersTypesPermissions
          #
          # list the permissions for using each trigger type
          #
          # @option options [array] :trigger_type_ids
          #   The trigger types IDs for which to get the permissions.
          # @see https://api.slack.com/methods/admin.workflows.triggers.types.permissions.lookup
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/admin.workflows.triggers.types.permissions/admin.workflows.triggers.types.permissions.lookup.json
          def admin_workflows_triggers_types_permissions_lookup(options = {})
            raise ArgumentError, 'Required arguments :trigger_type_ids missing' if options[:trigger_type_ids].nil?
            post('admin.workflows.triggers.types.permissions.lookup', options)
          end

          #
          # Set the permissions for using a trigger type
          #
          # @option options [Object] :id
          #   The trigger type ID for which to set the permissions.
          # @option options [enum] :visibility
          #   The function visibility.
          # @option options [array] :user_ids
          #   List of user IDs to allow for named_entities visibility.
          # @see https://api.slack.com/methods/admin.workflows.triggers.types.permissions.set
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/admin.workflows.triggers.types.permissions/admin.workflows.triggers.types.permissions.set.json
          def admin_workflows_triggers_types_permissions_set(options = {})
            raise ArgumentError, 'Required arguments :id missing' if options[:id].nil?
            raise ArgumentError, 'Required arguments :visibility missing' if options[:visibility].nil?
            post('admin.workflows.triggers.types.permissions.set', options)
          end
        end
      end
    end
  end
end
