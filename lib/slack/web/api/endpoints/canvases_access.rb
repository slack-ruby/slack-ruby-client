# frozen_string_literal: true
# This file was auto-generated by lib/tasks/web.rake

module Slack
  module Web
    module Api
      module Endpoints
        module CanvasesAccess
          #
          # Remove access to a canvas for specified entities
          #
          # @option options [Object] :canvas_id
          #   Encoded ID of the canvas.
          # @option options [array] :channel_ids
          #   List of channels you wish to update access for.
          # @option options [array] :user_ids
          #   List of users you wish to update access for.
          # @see https://api.slack.com/methods/canvases.access.delete
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/canvases.access/canvases.access.delete.json
          def canvases_access_delete(options = {})
            raise ArgumentError, 'Required arguments :canvas_id missing' if options[:canvas_id].nil?
            post('canvases.access.delete', options)
          end

          #
          # Sets the access level to a canvas for specified entities
          #
          # @option options [enum] :access_level
          #   Desired level of access.
          # @option options [Object] :canvas_id
          #   Encoded ID of the canvas.
          # @option options [array] :channel_ids
          #   List of channels you wish to update access for. Can only be used if user_ids is not provided.
          # @option options [array] :user_ids
          #   List of users you wish to update access for. Can only be used if channel_ids is not provided.
          # @see https://api.slack.com/methods/canvases.access.set
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/canvases.access/canvases.access.set.json
          def canvases_access_set(options = {})
            raise ArgumentError, 'Required arguments :access_level missing' if options[:access_level].nil?
            raise ArgumentError, 'Required arguments :canvas_id missing' if options[:canvas_id].nil?
            post('canvases.access.set', options)
          end
        end
      end
    end
  end
end
