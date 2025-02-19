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
          # @option params [string] :filename
          #   Name of the file being uploaded.
          # @option params [string] :content
          #   File contents via a POST variable.
          # @option params [string] :alt_txt
          #   Description of image for screen-reader.
          # @option params [string] :snippet_type
          #   Syntax type of the snippet being uploaded.
          # @option params [string] :title
          #   Title of file.
          # @option params [string] :channel_id
          #   Channel ID where the file will be shared. If not specified the file will be private.
          # @option params [string] :channel
          #   Channel where the file will be shared, alias of channel_id. If not specified the file will be private.
          # @option params [string] :channels
          #   Comma-separated string of channel IDs where the file will be shared. If not specified the file will be private.
          # @option params [string] :initial_comment
          #   The message text introducing the file in specified channels.
          # @option params [string] :thread_ts
          #   Provide another message's ts value to upload this file as a reply.
          #   Never use a reply's ts value; use its parent instead.
          #   Also make sure to provide only one channel when using 'thread_ts'.
          def files_upload_v2(params = {})
            %i[filename content].each do |param|
              raise ArgumentError, "Required argument :#{param} missing" if params[param].nil?
            end

            channel_params = %i[channel channels channel_id].map { |param| params[param] }.compact
            raise ArgumentError, 'Only one of :channel, :channels, or :channel_id is required' if channel_params.size > 1

            complete_upload_request_params = params.slice(:initial_comment, :thread_ts)

            if params[:channels]
              complete_upload_request_params[:channels] = Array(params[:channels]).map do |channel|
                conversations_id(channel: channel)['channel']['id']
              end.uniq.join(',')
            elsif params[:channel]
              complete_upload_request_params[:channel_id] = conversations_id(
                channel: params[:channel]
              )['channel']['id']
            elsif params[:channel_id]
              complete_upload_request_params[:channel_id] = params[:channel_id]
            end

            content = params[:content]
            title = params[:title] || params[:filename]

            upload_url_request_params = params.slice(:filename, :alt_txt, :snippet_type)
            upload_url_request_params[:length] = content.bytesize

            # Get the upload url.
            get_upload_url_response = files_getUploadURLExternal(upload_url_request_params)
            upload_url = get_upload_url_response[:upload_url]
            file_id = get_upload_url_response[:file_id]

            # Upload the file.
            ::Faraday::Connection.new(upload_url, options) do |connection|
              connection.request :multipart
              connection.request :url_encoded
              connection.use ::Slack::Web::Faraday::Response::WrapError
              connection.response :logger, logger if logger
              connection.adapter adapter
            end.post do |request|
              request.body = content
            end

            # Complete the upload.
            complete_upload_request_params[:files] = [{ id: file_id, title: title }].to_json

            files_completeUploadExternal(complete_upload_request_params)
          end
        end
      end
    end
  end
end
