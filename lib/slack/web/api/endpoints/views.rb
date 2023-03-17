# frozen_string_literal: true
# This file was auto-generated by lib/tasks/web.rake

module Slack
  module Web
    module Api
      module Endpoints
        module Views
          #
          # Open a view for a user.
          #
          # @option options [view as string] :view
          #   A view payload. This must be a JSON-encoded string.
          # @option options [string] :trigger_id
          #   Exchange a trigger to post to the user.
          # @option options [string] :interactivity_pointer
          #   Exchange an interactivity pointer to post to the user.
          # @see https://api.slack.com/methods/views.open
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/views/views.open.json
          def views_open(options = {})
            raise ArgumentError, 'Required arguments :view missing' if options[:view].nil?
            options = encode_options('views', options)
            post('views.open', options)
          end

          #
          # Publish a static view for a User.
          #
          # @option options [string] :user_id
          #   id of the user you want publish a view to.
          # @option options [view as string] :view
          #   A view payload. This must be a JSON-encoded string.
          # @option options [string] :hash
          #   A string that represents view state to protect against possible race conditions.
          # @see https://api.slack.com/methods/views.publish
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/views/views.publish.json
          def views_publish(options = {})
            raise ArgumentError, 'Required arguments :user_id missing' if options[:user_id].nil?
            raise ArgumentError, 'Required arguments :view missing' if options[:view].nil?
            options = encode_options('views', options)
            post('views.publish', options)
          end

          #
          # Push a view onto the stack of a root view.
          #
          # @option options [view as string] :view
          #   A view payload. This must be a JSON-encoded string.
          # @option options [string] :trigger_id
          #   Exchange a trigger to post to the user.
          # @option options [string] :interactivity_pointer
          #   Exchange an interactivity pointer to post to the user.
          # @see https://api.slack.com/methods/views.push
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/views/views.push.json
          def views_push(options = {})
            raise ArgumentError, 'Required arguments :view missing' if options[:view].nil?
            options = encode_options('views', options)
            post('views.push', options)
          end

          #
          # Update an existing view.
          #
          # @option options [view as string] :view
          #   A view object. This must be a JSON-encoded string.
          # @option options [string] :external_id
          #   A unique identifier of the view set by the developer. Must be unique for all views on a team. Max length of 255 characters. Either view_id or external_id is required.
          # @option options [string] :view_id
          #   A unique identifier of the view to be updated. Either view_id or external_id is required.
          # @option options [string] :hash
          #   A string that represents view state to protect against possible race conditions.
          # @see https://api.slack.com/methods/views.update
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/views/views.update.json
          def views_update(options = {})
            raise ArgumentError, 'Required arguments :view missing' if options[:view].nil?
            options = encode_options('views', options)
            post('views.update', options)
          end
        end
      end
    end
  end
end
