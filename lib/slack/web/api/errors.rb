# frozen_string_literal: true
# This file was auto-generated by lib/tasks/web.rake

require_relative 'errors/account_inactive'
require_relative 'errors/already_archived'
require_relative 'errors/already_in_channel'
require_relative 'errors/already_pinned'
require_relative 'errors/already_reacted'
require_relative 'errors/already_starred'
require_relative 'errors/app_missing_action_url'
require_relative 'errors/bad_client_secret'
require_relative 'errors/bad_image'
require_relative 'errors/bad_timestamp'
require_relative 'errors/bad_token'
require_relative 'errors/bot_not_found'
require_relative 'errors/cannot_add_bot'
require_relative 'errors/cannot_add_others'
require_relative 'errors/cannot_add_others_recurring'
require_relative 'errors/cannot_add_slackbot'
require_relative 'errors/cannot_complete_others'
require_relative 'errors/cannot_complete_recurring'
require_relative 'errors/cannot_create_dialog'
require_relative 'errors/cannot_find_service'
require_relative 'errors/cannot_parse'
require_relative 'errors/cannot_prompt'
require_relative 'errors/cannot_unfurl_url'
require_relative 'errors/cannot_update_admin_user'
require_relative 'errors/cant_archive_general'
require_relative 'errors/cant_delete'
require_relative 'errors/cant_delete_file'
require_relative 'errors/cant_delete_message'
require_relative 'errors/cant_invite'
require_relative 'errors/cant_invite_self'
require_relative 'errors/cant_kick_from_general'
require_relative 'errors/cant_kick_self'
require_relative 'errors/cant_leave_general'
require_relative 'errors/cant_leave_mandatory_shared_channel'
require_relative 'errors/cant_update_message'
require_relative 'errors/channel_not_found'
require_relative 'errors/client_id_token_mismatch'
require_relative 'errors/comment_not_found'
require_relative 'errors/compliance_exports_prevent_deletion'
require_relative 'errors/edit_window_closed'
require_relative 'errors/ekm_access_denied'
require_relative 'errors/enterprise_is_restricted'
require_relative 'errors/failed_sending_dialog'
require_relative 'errors/fatal_error'
require_relative 'errors/fetch_members_failed'
require_relative 'errors/file_comment_not_found'
require_relative 'errors/file_deleted'
require_relative 'errors/file_not_found'
require_relative 'errors/file_not_shared'
require_relative 'errors/file_uploads_disabled'
require_relative 'errors/file_uploads_except_images_disabled'
require_relative 'errors/group_contains_others'
require_relative 'errors/invalid_arg_name'
require_relative 'errors/invalid_arguments'
require_relative 'errors/invalid_array_arg'
require_relative 'errors/invalid_auth'
require_relative 'errors/invalid_channel'
require_relative 'errors/invalid_charset'
require_relative 'errors/invalid_client_id'
require_relative 'errors/invalid_cursor'
require_relative 'errors/invalid_for_external_shared_channel'
require_relative 'errors/invalid_form_data'
require_relative 'errors/invalid_json'
require_relative 'errors/invalid_limit'
require_relative 'errors/invalid_name'
require_relative 'errors/invalid_name_maxlength'
require_relative 'errors/invalid_name_punctuation'
require_relative 'errors/invalid_name_required'
require_relative 'errors/invalid_name_specials'
require_relative 'errors/invalid_post_typ'
require_relative 'errors/invalid_post_type'
require_relative 'errors/invalid_presence'
require_relative 'errors/invalid_profile'
require_relative 'errors/invalid_scheduled_message_id'
require_relative 'errors/invalid_scope'
require_relative 'errors/invalid_time'
require_relative 'errors/invalid_timestamp'
require_relative 'errors/invalid_trigger'
require_relative 'errors/invalid_ts_latest'
require_relative 'errors/invalid_ts_oldest'
require_relative 'errors/invalid_types'
require_relative 'errors/invalid_user'
require_relative 'errors/is_archived'
require_relative 'errors/json_not_object'
require_relative 'errors/last_member'
require_relative 'errors/limit_required'
require_relative 'errors/message_not_found'
require_relative 'errors/method_not_supported_for_channel_type'
require_relative 'errors/missing_charset'
require_relative 'errors/missing_dialog'
require_relative 'errors/missing_duration'
require_relative 'errors/missing_post_typ'
require_relative 'errors/missing_post_type'
require_relative 'errors/missing_scope'
require_relative 'errors/missing_trigger'
require_relative 'errors/missing_unfurls'
require_relative 'errors/msg_too_long'
require_relative 'errors/name_taken'
require_relative 'errors/no_channel'
require_relative 'errors/no_item_specified'
require_relative 'errors/no_permission'
require_relative 'errors/no_reaction'
require_relative 'errors/no_text'
require_relative 'errors/no_user'
require_relative 'errors/not_admin'
require_relative 'errors/not_allowed'
require_relative 'errors/not_app_admin'
require_relative 'errors/not_archived'
require_relative 'errors/not_authed'
require_relative 'errors/not_authorized'
require_relative 'errors/not_enough_users'
require_relative 'errors/not_enterprise_team'
require_relative 'errors/not_found'
require_relative 'errors/not_in_channel'
require_relative 'errors/not_in_group'
require_relative 'errors/not_pinnable'
require_relative 'errors/not_pinned'
require_relative 'errors/not_starred'
require_relative 'errors/not_supported'
require_relative 'errors/org_login_required'
require_relative 'errors/over_pagination_limit'
require_relative 'errors/paid_only'
require_relative 'errors/permission_denied'
require_relative 'errors/posting_to_general_channel_denied'
require_relative 'errors/profile_set_failed'
require_relative 'errors/rate_limited'
require_relative 'errors/request_timeou'
require_relative 'errors/request_timeout'
require_relative 'errors/reserved_name'
require_relative 'errors/restricted_action'
require_relative 'errors/restricted_action_non_threadable_channel'
require_relative 'errors/restricted_action_read_only_channel'
require_relative 'errors/restricted_action_thread_only_channel'
require_relative 'errors/snooze_end_failed'
require_relative 'errors/snooze_failed'
require_relative 'errors/snooze_not_active'
require_relative 'errors/storage_limit_reached'
require_relative 'errors/superfluous_charset'
require_relative 'errors/team_added_to_org'
require_relative 'errors/thread_not_found'
require_relative 'errors/time_in_past'
require_relative 'errors/time_too_far'
require_relative 'errors/timezone_count_failed'
require_relative 'errors/token_revoked'
require_relative 'errors/too_large'
require_relative 'errors/too_long'
require_relative 'errors/too_many_attachments'
require_relative 'errors/too_many_emoji'
require_relative 'errors/too_many_frames'
require_relative 'errors/too_many_reactions'
require_relative 'errors/too_many_users'
require_relative 'errors/trigger_exchanged'
require_relative 'errors/trigger_expired'
require_relative 'errors/unknown_error'
require_relative 'errors/unknown_type'
require_relative 'errors/upgrade_require'
require_relative 'errors/upgrade_required'
require_relative 'errors/ura_max_channels'
require_relative 'errors/user_disabled'
require_relative 'errors/user_does_not_own_channel'
require_relative 'errors/user_is_bot'
require_relative 'errors/user_is_restricted'
require_relative 'errors/user_is_ultra_restricted'
require_relative 'errors/user_not_found'
require_relative 'errors/user_not_in_channel'
require_relative 'errors/user_not_visible'
require_relative 'errors/users_list_not_supplied'
require_relative 'errors/users_not_found'
require_relative 'errors/validation_errors'

module Slack
  module Web
    module Api
      module Errors
        ERROR_CLASSES = {
          'account_inactive' => AccountInactive,
          'already_archived' => AlreadyArchived,
          'already_in_channel' => AlreadyInChannel,
          'already_pinned' => AlreadyPinned,
          'already_reacted' => AlreadyReacted,
          'already_starred' => AlreadyStarred,
          'app_missing_action_url' => AppMissingActionUrl,
          'bad_client_secret' => BadClientSecret,
          'bad_image' => BadImage,
          'bad_timestamp' => BadTimestamp,
          'bad_token' => BadToken,
          'bot_not_found' => BotNotFound,
          'cannot_add_bot' => CannotAddBot,
          'cannot_add_others' => CannotAddOthers,
          'cannot_add_others_recurring' => CannotAddOthersRecurring,
          'cannot_add_slackbot' => CannotAddSlackbot,
          'cannot_complete_others' => CannotCompleteOthers,
          'cannot_complete_recurring' => CannotCompleteRecurring,
          'cannot_create_dialog' => CannotCreateDialog,
          'cannot_find_service' => CannotFindService,
          'cannot_parse' => CannotParse,
          'cannot_prompt' => CannotPrompt,
          'cannot_unfurl_url' => CannotUnfurlUrl,
          'cannot_update_admin_user' => CannotUpdateAdminUser,
          'cant_archive_general' => CantArchiveGeneral,
          'cant_delete' => CantDelete,
          'cant_delete_file' => CantDeleteFile,
          'cant_delete_message' => CantDeleteMessage,
          'cant_invite' => CantInvite,
          'cant_invite_self' => CantInviteSelf,
          'cant_kick_from_general' => CantKickFromGeneral,
          'cant_kick_self' => CantKickSelf,
          'cant_leave_general' => CantLeaveGeneral,
          'cant_leave_mandatory_shared_channel' => CantLeaveMandatorySharedChannel,
          'cant_update_message' => CantUpdateMessage,
          'channel_not_found' => ChannelNotFound,
          'client_id_token_mismatch' => ClientIdTokenMismatch,
          'comment_not_found' => CommentNotFound,
          'compliance_exports_prevent_deletion' => ComplianceExportsPreventDeletion,
          'edit_window_closed' => EditWindowClosed,
          'ekm_access_denied' => EkmAccessDenied,
          'enterprise_is_restricted' => EnterpriseIsRestricted,
          'failed_sending_dialog' => FailedSendingDialog,
          'fatal_error' => FatalError,
          'fetch_members_failed' => FetchMembersFailed,
          'file_comment_not_found' => FileCommentNotFound,
          'file_deleted' => FileDeleted,
          'file_not_found' => FileNotFound,
          'file_not_shared' => FileNotShared,
          'file_uploads_disabled' => FileUploadsDisabled,
          'file_uploads_except_images_disabled' => FileUploadsExceptImagesDisabled,
          'group_contains_others' => GroupContainsOthers,
          'invalid_arg_name' => InvalidArgName,
          'invalid_arguments' => InvalidArguments,
          'invalid_array_arg' => InvalidArrayArg,
          'invalid_auth' => InvalidAuth,
          'invalid_channel' => InvalidChannel,
          'invalid_charset' => InvalidCharset,
          'invalid_client_id' => InvalidClientId,
          'invalid_cursor' => InvalidCursor,
          'invalid_for_external_shared_channel' => InvalidForExternalSharedChannel,
          'invalid_form_data' => InvalidFormData,
          'invalid_json' => InvalidJson,
          'invalid_limit' => InvalidLimit,
          'invalid_name' => InvalidName,
          'invalid_name_maxlength' => InvalidNameMaxlength,
          'invalid_name_punctuation' => InvalidNamePunctuation,
          'invalid_name_required' => InvalidNameRequired,
          'invalid_name_specials' => InvalidNameSpecials,
          'invalid_post_typ' => InvalidPostTyp,
          'invalid_post_type' => InvalidPostType,
          'invalid_presence' => InvalidPresence,
          'invalid_profile' => InvalidProfile,
          'invalid_scheduled_message_id' => InvalidScheduledMessageId,
          'invalid_scope' => InvalidScope,
          'invalid_time' => InvalidTime,
          'invalid_timestamp' => InvalidTimestamp,
          'invalid_trigger' => InvalidTrigger,
          'invalid_ts_latest' => InvalidTsLatest,
          'invalid_ts_oldest' => InvalidTsOldest,
          'invalid_types' => InvalidTypes,
          'invalid_user' => InvalidUser,
          'is_archived' => IsArchived,
          'json_not_object' => JsonNotObject,
          'last_member' => LastMember,
          'limit_required' => LimitRequired,
          'message_not_found' => MessageNotFound,
          'method_not_supported_for_channel_type' => MethodNotSupportedForChannelType,
          'missing_charset' => MissingCharset,
          'missing_dialog' => MissingDialog,
          'missing_duration' => MissingDuration,
          'missing_post_typ' => MissingPostTyp,
          'missing_post_type' => MissingPostType,
          'missing_scope' => MissingScope,
          'missing_trigger' => MissingTrigger,
          'missing_unfurls' => MissingUnfurls,
          'msg_too_long' => MsgTooLong,
          'name_taken' => NameTaken,
          'no_channel' => NoChannel,
          'no_item_specified' => NoItemSpecified,
          'no_permission' => NoPermission,
          'no_reaction' => NoReaction,
          'no_text' => NoText,
          'no_user' => NoUser,
          'not_admin' => NotAdmin,
          'not_allowed' => NotAllowed,
          'not_app_admin' => NotAppAdmin,
          'not_archived' => NotArchived,
          'not_authed' => NotAuthed,
          'not_authorized' => NotAuthorized,
          'not_enough_users' => NotEnoughUsers,
          'not_enterprise_team' => NotEnterpriseTeam,
          'not_found' => NotFound,
          'not_in_channel' => NotInChannel,
          'not_in_group' => NotInGroup,
          'not_pinnable' => NotPinnable,
          'not_pinned' => NotPinned,
          'not_starred' => NotStarred,
          'not_supported' => NotSupported,
          'org_login_required' => OrgLoginRequired,
          'over_pagination_limit' => OverPaginationLimit,
          'paid_only' => PaidOnly,
          'permission_denied' => PermissionDenied,
          'posting_to_general_channel_denied' => PostingToGeneralChannelDenied,
          'profile_set_failed' => ProfileSetFailed,
          'rate_limited' => RateLimited,
          'request_timeou' => RequestTimeou,
          'request_timeout' => RequestTimeout,
          'reserved_name' => ReservedName,
          'restricted_action' => RestrictedAction,
          'restricted_action_non_threadable_channel' => RestrictedActionNonThreadableChannel,
          'restricted_action_read_only_channel' => RestrictedActionReadOnlyChannel,
          'restricted_action_thread_only_channel' => RestrictedActionThreadOnlyChannel,
          'snooze_end_failed' => SnoozeEndFailed,
          'snooze_failed' => SnoozeFailed,
          'snooze_not_active' => SnoozeNotActive,
          'storage_limit_reached' => StorageLimitReached,
          'superfluous_charset' => SuperfluousCharset,
          'team_added_to_org' => TeamAddedToOrg,
          'thread_not_found' => ThreadNotFound,
          'time_in_past' => TimeInPast,
          'time_too_far' => TimeTooFar,
          'timezone_count_failed' => TimezoneCountFailed,
          'token_revoked' => TokenRevoked,
          'too_large' => TooLarge,
          'too_long' => TooLong,
          'too_many_attachments' => TooManyAttachments,
          'too_many_emoji' => TooManyEmoji,
          'too_many_frames' => TooManyFrames,
          'too_many_reactions' => TooManyReactions,
          'too_many_users' => TooManyUsers,
          'trigger_exchanged' => TriggerExchanged,
          'trigger_expired' => TriggerExpired,
          'unknown_error' => UnknownError,
          'unknown_type' => UnknownType,
          'upgrade_require' => UpgradeRequire,
          'upgrade_required' => UpgradeRequired,
          'ura_max_channels' => UraMaxChannels,
          'user_disabled' => UserDisabled,
          'user_does_not_own_channel' => UserDoesNotOwnChannel,
          'user_is_bot' => UserIsBot,
          'user_is_restricted' => UserIsRestricted,
          'user_is_ultra_restricted' => UserIsUltraRestricted,
          'user_not_found' => UserNotFound,
          'user_not_in_channel' => UserNotInChannel,
          'user_not_visible' => UserNotVisible,
          'users_list_not_supplied' => UsersListNotSupplied,
          'users_not_found' => UsersNotFound,
          'validation_errors' => ValidationErrors,
        }.freeze
      end
    end
  end
end
