# frozen_string_literal: true
module Slack
  module Web
    module Api
      module Helpers
        module Files
          #
          # Uses Slack APIs new sequential file upload flow. This replaces the files.upload method
          # @see https://api.slack.com/changelog/2024-04-a-better-way-to-upload-files-is-here-to-stay
          # @see https://api.slack.com/messaging/files#uploading_files
          #
          # @option options [string] :filename
          #   Name of the file being uploaded.
          # @option options [string] :content
          #   File contents via a POST variable.
          # @option options [string] :alt_txt
          #   Description of image for screen-reader.
          # @option options [string] :snippet_type
          #   Syntax type of the snippet being uploaded.
          # @option options [string] :title
          #   Title of file.
          # @option options [string] :channels
          #   Comma-separated string of channel IDs where the file will be shared. If not specified the file will be private.
          # @option options [string] :initial_comment
          #   The message text introducing the file in specified channels.
          # @option options [string] :thread_ts
          #   Provide another message's ts value to upload this file as a reply.
          #   Never use a reply's ts value; use its parent instead.
          #   Also make sure to provide only one channel when using 'thread_ts'.
          def files_upload_v2(options = {})
            %i[filename content channels].each do |param|
              raise ArgumentError, "Required argument :#{param} missing" if options[param].nil?
            end

            content = options[:content]
            title = options[:title] || options[:filename]

            upload_url_request_params = options.slice(:filename, :alt_txt, :snippet_type)
            upload_url_request_params[:length] = content.bytesize

            # 1. get the upload url
            get_upload_url_response = files_getUploadURLExternal(upload_url_request_params)
            upload_url = get_upload_url_response[:upload_url]
            file_id = get_upload_url_response[:file_id]

            # 2. upload the file and do not process the return body
            post(upload_url, content, false)

            # 3. complete the upload
            complete_upload_request_params = options.slice(:channels, :initial_comment, :thread_ts)
            complete_upload_request_params[:files] = [{ id: file_id, title: title }].to_json

            files_completeUploadExternal(complete_upload_request_params)
          end
        end
      end
    end
  end
end
