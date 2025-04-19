# frozen_string_literal: true
# This file was auto-generated by lib/tasks/web.rake

module Slack
  module Web
    module Api
      module Endpoints
        module AssistantSearch
          #
          # Searches messages across your Slack organization—perfect for broad, specific, and real-time data retrieval.
          #
          # @option options [string] :query
          #   User prompt or search query.
          # @option options [string] :action_token
          #   Send action_token as received in a message event.
          # @option options [array] :channel_types
          #   Mix and match channel types by providing a comma-separated list of any combination of public_channel, private_channel, mpim, im.
          # @option options [array] :content_types
          #   Content types to include, a comma-separated list of any combination of messages, files.
          # @option options [Object] :context_channel_id
          #   Context channel ID to support scoping the search when applicable.
          # @option options [string] :cursor
          #   The cursor returned by the API. Leave this blank for the first request, and use this to get the next page of results.
          # @option options [boolean] :include_bots
          #   If you want the results to include bots.
          # @option options [integer] :limit
          #   Number of results to return, up to a max of 20. Defaults to 20.
          # @see https://api.slack.com/methods/assistant.search.context
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/assistant.search/assistant.search.context.json
          def assistant_search_context(options = {})
            raise ArgumentError, 'Required arguments :query missing' if options[:query].nil?
            if block_given?
              Pagination::Cursor.new(self, :assistant_search_context, options).each do |page|
                yield page
              end
            else
              post('assistant.search.context', options)
            end
          end
        end
      end
    end
  end
end
