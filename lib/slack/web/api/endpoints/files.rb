# frozen_string_literal: true
# This file was auto-generated by lib/tasks/web.rake

module Slack
  module Web
    module Api
      module Endpoints
        module Files
          #
          # Finishes an upload started with files.getUploadURLExternal
          #
          # @option options [array] :files
          #   Array of file ids and their corresponding (optional) titles.
          # @option options [Object] :channel_id
          #   Channel ID where the file will be shared. If not specified the file will be private.
          # @option options [string] :channels
          #   Comma-separated string of channel IDs where the file will be shared.
          # @option options [string] :initial_comment
          #   The message text introducing the file in specified channels.
          # @option options [string] :thread_ts
          #   Provide another message's ts value to upload this file as a reply. Never use a reply's ts value; use its parent instead. Also make sure to provide only one channel when using 'thread_ts'.
          # @see https://api.slack.com/methods/files.completeUploadExternal
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/files/files.completeUploadExternal.json
          def files_completeUploadExternal(options = {})
            raise ArgumentError, 'Required arguments :files missing' if options[:files].nil?
            post('files.completeUploadExternal', options)
          end

          #
          # Deletes a file.
          #
          # @option options [file] :file
          #   ID of file to delete.
          # @see https://api.slack.com/methods/files.delete
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/files/files.delete.json
          def files_delete(options = {})
            raise ArgumentError, 'Required arguments :file missing' if options[:file].nil?
            post('files.delete', options)
          end

          #
          # Change the properties of a file (undocumented)
          #
          # @option options [Object] :file
          #   ID of the file to be edited
          # @option options [Object] :title
          #   New title of the file
          # @option options [Object] :filetype
          #   New filetype of the file. See https://api.slack.com/types/file#file_types for a list of all supported types.
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/undocumented/files/files.edit.json
          def files_edit(options = {})
            raise ArgumentError, 'Required arguments :file missing' if options[:file].nil?
            raise ArgumentError, 'Required arguments :title missing' if options[:title].nil?
            logger.warn('The files.edit method is undocumented.')
            post('files.edit', options)
          end

          #
          # Gets a URL for an edge external file upload
          #
          # @option options [string] :filename
          #   Name of the file being uploaded.
          # @option options [integer] :length
          #   Size in bytes of the file being uploaded.
          # @option options [string] :alt_txt
          #   Description of image for screen-reader.
          # @option options [string] :snippet_type
          #   Syntax type of the snippet being uploaded.
          # @see https://api.slack.com/methods/files.getUploadURLExternal
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/files/files.getUploadURLExternal.json
          def files_getUploadURLExternal(options = {})
            raise ArgumentError, 'Required arguments :filename missing' if options[:filename].nil?
            raise ArgumentError, 'Required arguments :length missing' if options[:length].nil?
            post('files.getUploadURLExternal', options)
          end

          #
          # Gets information about a file.
          #
          # @option options [file] :file
          #   Specify a file by providing its ID.
          # @option options [string] :cursor
          #   Parameter for pagination. File comments are paginated for a single file. Set cursor equal to the next_cursor attribute returned by the previous request's response_metadata. This parameter is optional, but pagination is mandatory: the default value simply fetches the first "page" of the collection of comments. See pagination for more details.
          # @option options [integer] :limit
          #   The maximum number of items to return. Fewer than the requested number of items may be returned, even if the end of the list hasn't been reached.
          # @see https://api.slack.com/methods/files.info
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/files/files.info.json
          def files_info(options = {})
            raise ArgumentError, 'Required arguments :file missing' if options[:file].nil?
            if block_given?
              Pagination::Cursor.new(self, :files_info, options).each do |page|
                yield page
              end
            else
              post('files.info', options)
            end
          end

          #
          # List for a team, in a channel, or from a user with applied filters.
          #
          # @option options [channel] :channel
          #   Filter files appearing in a specific channel, indicated by its ID.
          # @option options [boolean] :show_files_hidden_by_limit
          #   Show truncated file info for files hidden due to being too old, and the team who owns the file being over the file limit.
          # @option options [string] :team_id
          #   encoded team id to list files in, required if org token is used.
          # @option options [string] :ts_from
          #   Filter files created after this timestamp (inclusive).
          # @option options [string] :ts_to
          #   Filter files created before this timestamp (inclusive).
          # @option options [string] :types
          #   Filter files by type (see below). You can pass multiple values in the types argument, like types=spaces,snippets.The default value is all, which does not filter the list.
          # @option options [user] :user
          #   Filter files created by a single user.
          # @see https://api.slack.com/methods/files.list
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/files/files.list.json
          def files_list(options = {})
            options = options.merge(channel: conversations_id(options)['channel']['id']) if options[:channel]
            options = options.merge(user: users_id(options)['user']['id']) if options[:user]
            post('files.list', options)
          end

          #
          # Revokes public/external sharing access for a file
          #
          # @option options [file] :file
          #   File to revoke.
          # @see https://api.slack.com/methods/files.revokePublicURL
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/files/files.revokePublicURL.json
          def files_revokePublicURL(options = {})
            raise ArgumentError, 'Required arguments :file missing' if options[:file].nil?
            post('files.revokePublicURL', options)
          end

          #
          # Share an existing file in a channel (undocumented)
          #
          # @option options [Object] :file
          #   ID of the file to be shared
          # @option options [channel] :channel
          #   Channel to share the file in. Works with both public (channel ID) and private channels (group ID).
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/undocumented/files/files.share.json
          def files_share(options = {})
            raise ArgumentError, 'Required arguments :file missing' if options[:file].nil?
            raise ArgumentError, 'Required arguments :channel missing' if options[:channel].nil?
            options = options.merge(channel: conversations_id(options)['channel']['id']) if options[:channel]
            logger.warn('The files.share method is undocumented.')
            post('files.share', options)
          end

          #
          # Enables a file for public/external sharing.
          #
          # @option options [file] :file
          #   File to share.
          # @see https://api.slack.com/methods/files.sharedPublicURL
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/files/files.sharedPublicURL.json
          def files_sharedPublicURL(options = {})
            raise ArgumentError, 'Required arguments :file missing' if options[:file].nil?
            post('files.sharedPublicURL', options)
          end

          #
          # Uploads or creates a file.
          #
          # @option options [string] :channels
          #   Comma-separated list of channel names or IDs where the file will be shared.
          # @option options [string] :content
          #   File contents via a POST variable. If omitting this parameter, you must provide a file.
          # @option options [file] :file
          #   File contents via multipart/form-data. If omitting this parameter, you must submit content.
          # @option options [string] :filename
          #   Filename of file.
          # @option options [string] :filetype
          #   A file type identifier.
          # @option options [string] :initial_comment
          #   The message text introducing the file in specified channels.
          # @option options [string] :thread_ts
          #   Provide another message's ts value to upload this file as a reply. Never use a reply's ts value; use its parent instead.
          # @option options [string] :title
          #   Title of file.
          # @see https://api.slack.com/methods/files.upload
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/files/files.upload.json
          def files_upload(options = {})
            options = options.merge(filename: 'file') if options[:file] && !options[:filename]
            post('files.upload', options)
          end
        end
      end
    end
  end
end
