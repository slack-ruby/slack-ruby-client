# frozen_string_literal: true
# This file was auto-generated by lib/tasks/web.rake

module Slack
  module Web
    module Api
      module Endpoints
        module AssistantThreads
          #
          # Set the status for an AI assistant thread.
          #
          # @option options [Object] :channel_id
          #   Channel ID containing the assistant thread.
          # @option options [string] :status
          #   Status of the specified bot user, e.g. 'is thinking...'.
          # @option options [string] :thread_ts
          #   Message timestamp of the thread of where to set the status.
          # @see https://api.slack.com/methods/assistant.threads.setStatus
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/assistant.threads/assistant.threads.setStatus.json
          def assistant_threads_setStatus(options = {})
            raise ArgumentError, 'Required arguments :channel_id missing' if options[:channel_id].nil?
            raise ArgumentError, 'Required arguments :status missing' if options[:status].nil?
            raise ArgumentError, 'Required arguments :thread_ts missing' if options[:thread_ts].nil?
            post('assistant.threads.setStatus', options)
          end

          #
          # Set suggested prompts for the given assistant thread
          #
          # @option options [Object] :channel_id
          #   Channel ID containing the assistant thread.
          # @option options [Object] :prompts
          #   Each prompt should be supplied with its title and message attribute.
          # @option options [string] :thread_ts
          #   Message timestamp of the thread to set suggested prompts for.
          # @option options [string] :title
          #   Title for the list of provided prompts. For example: Suggested Prompts, Related Questions.
          # @see https://api.slack.com/methods/assistant.threads.setSuggestedPrompts
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/assistant.threads/assistant.threads.setSuggestedPrompts.json
          def assistant_threads_setSuggestedPrompts(options = {})
            raise ArgumentError, 'Required arguments :channel_id missing' if options[:channel_id].nil?
            raise ArgumentError, 'Required arguments :prompts missing' if options[:prompts].nil?
            raise ArgumentError, 'Required arguments :thread_ts missing' if options[:thread_ts].nil?
            post('assistant.threads.setSuggestedPrompts', options)
          end

          #
          # Set the title for the given assistant thread
          #
          # @option options [Object] :channel_id
          #   Channel ID containing the assistant thread.
          # @option options [string] :thread_ts
          #   Message timestamp of the thread to set suggested prompts for.
          # @option options [string] :title
          #   The title to use for the thread.
          # @see https://api.slack.com/methods/assistant.threads.setTitle
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/assistant.threads/assistant.threads.setTitle.json
          def assistant_threads_setTitle(options = {})
            raise ArgumentError, 'Required arguments :channel_id missing' if options[:channel_id].nil?
            raise ArgumentError, 'Required arguments :thread_ts missing' if options[:thread_ts].nil?
            raise ArgumentError, 'Required arguments :title missing' if options[:title].nil?
            post('assistant.threads.setTitle', options)
          end
        end
      end
    end
  end
end