# frozen_string_literal: true
# This file was auto-generated by lib/tasks/web.rake

desc 'AdminUsers methods.'
command 'admin_users' do |g|
  g.desc 'Add an Enterprise user to a workspace.'
  g.long_desc %( Add an Enterprise user to a workspace. )
  g.command 'assign' do |c|
    c.flag 'team_id', desc: 'The ID (T1234) of the workspace.'
    c.flag 'user_id', desc: 'The ID of the user to add to the workspace.'
    c.flag 'is_restricted', desc: 'True if user should be added to the workspace as a guest.'
    c.flag 'is_ultra_restricted', desc: 'True if user should be added to the workspace as a single-channel guest.'
    c.action do |_global_options, options, _args|
      puts JSON.dump($client.admin_users_assign(options))
    end
  end

  g.desc 'Invite a user to a workspace.'
  g.long_desc %( Invite a user to a workspace. )
  g.command 'invite' do |c|
    c.flag 'channel_ids', desc: 'A comma-separated list of channel_ids for this user to join. At least one channel is required.'
    c.flag 'email', desc: 'The email address of the person to invite.'
    c.flag 'team_id', desc: 'The ID (T1234) of the workspace.'
    c.flag 'custom_message', desc: 'An optional message to send to the user in the invite email.'
    c.flag 'guest_expiration_ts', desc: 'Timestamp when guest account should be disabled. Only include this timestamp if you are inviting a guest user and you want their account to expire on a certain date.'
    c.flag 'is_restricted', desc: 'Is this user a multi-channel guest user? (default: false).'
    c.flag 'is_ultra_restricted', desc: 'Is this user a single channel guest user? (default: false).'
    c.flag 'real_name', desc: 'Full name of the user.'
    c.flag 'resend', desc: 'Allow this invite to be resent in the future if a user has not signed up yet. (default: false).'
    c.action do |_global_options, options, _args|
      puts JSON.dump($client.admin_users_invite(options))
    end
  end

  g.desc 'Remove a user from a workspace.'
  g.long_desc %( Remove a user from a workspace. )
  g.command 'remove' do |c|
    c.flag 'team_id', desc: 'The ID (T1234) of the workspace.'
    c.flag 'user_id', desc: 'The ID of the user to remove.'
    c.action do |_global_options, options, _args|
      puts JSON.dump($client.admin_users_remove(options))
    end
  end

  g.desc 'Set an existing guest, regular user, or owner to be an admin user.'
  g.long_desc %( Set an existing guest, regular user, or owner to be an admin user. )
  g.command 'setAdmin' do |c|
    c.flag 'team_id', desc: 'The ID (T1234) of the workspace.'
    c.flag 'user_id', desc: 'The ID of the user to designate as an admin.'
    c.action do |_global_options, options, _args|
      puts JSON.dump($client.admin_users_setAdmin(options))
    end
  end

  g.desc 'Set an existing guest, regular user, or admin user to be a workspace owner.'
  g.long_desc %( Set an existing guest, regular user, or admin user to be a workspace owner. )
  g.command 'setOwner' do |c|
    c.flag 'team_id', desc: 'The ID (T1234) of the workspace.'
    c.flag 'user_id', desc: 'Id of the user to promote to owner.'
    c.action do |_global_options, options, _args|
      puts JSON.dump($client.admin_users_setOwner(options))
    end
  end

  g.desc 'Set an existing guest user, admin user, or owner to be a regular user.'
  g.long_desc %( Set an existing guest user, admin user, or owner to be a regular user. )
  g.command 'setRegular' do |c|
    c.flag 'team_id', desc: 'The ID (T1234) of the workspace.'
    c.flag 'user_id', desc: 'The ID of the user to designate as a regular user.'
    c.action do |_global_options, options, _args|
      puts JSON.dump($client.admin_users_setRegular(options))
    end
  end
end
