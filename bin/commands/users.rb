# frozen_string_literal: true
# This file was auto-generated by lib/tasks/web.rake

desc 'Users methods.'
command 'users' do |g|
  g.desc 'List conversations the calling user may access.'
  g.long_desc %( List conversations the calling user may access. )
  g.command 'conversations' do |c|
    c.flag 'cursor', desc: "Paginate through collections of data by setting the cursor parameter to a next_cursor attribute returned by a previous request's response_metadata. Default value fetches the first 'page' of the collection. See pagination for more detail."
    c.flag 'exclude_archived', desc: 'Set to true to exclude archived channels from the list.'
    c.flag 'limit', desc: "The maximum number of items to return. Fewer than the requested number of items may be returned, even if the end of the list hasn't been reached. Must be an integer no larger than 1000."
    c.flag 'types', desc: 'Mix and match channel types by providing a comma-separated list of any combination of public_channel, private_channel, mpim, im.'
    c.flag 'user', desc: "Browse conversations by a specific user ID's membership. Non-public channels are restricted to those where the calling user shares membership."
    c.action do |_global_options, options, _args|
      puts JSON.dump($client.users_conversations(options))
    end
  end

  g.desc 'Delete the user profile photo'
  g.long_desc %( Delete the user profile photo )
  g.command 'deletePhoto' do |c|
    c.action do |_global_options, options, _args|
      puts JSON.dump($client.users_deletePhoto(options))
    end
  end

  g.desc 'Gets user presence information.'
  g.long_desc %( Gets user presence information. )
  g.command 'getPresence' do |c|
    c.flag 'user', desc: 'User to get presence info on. Defaults to the authed user.'
    c.action do |_global_options, options, _args|
      puts JSON.dump($client.users_getPresence(options))
    end
  end

  g.desc 'This method returns the ID of a team user.'
  g.long_desc %( This method returns the ID of a team user. )
  g.command 'id' do |c|
    c.flag 'user', desc: 'User to get ID for, prefixed with @.'
    c.action do |_global_options, options, _args|
      puts JSON.dump($client.users_id(options))
    end
  end

  g.desc "Get a user's identity."
  g.long_desc %( Get a user's identity. )
  g.command 'identity' do |c|
    c.action do |_global_options, options, _args|
      puts JSON.dump($client.users_identity(options))
    end
  end

  g.desc 'Gets information about a user.'
  g.long_desc %( Gets information about a user. )
  g.command 'info' do |c|
    c.flag 'user', desc: 'User to get info on.'
    c.flag 'include_locale', desc: 'Set this to true to receive the locale for this user. Defaults to false.'
    c.action do |_global_options, options, _args|
      puts JSON.dump($client.users_info(options))
    end
  end

  g.desc 'Lists all users in a Slack team.'
  g.long_desc %( Lists all users in a Slack team. )
  g.command 'list' do |c|
    c.flag 'cursor', desc: "Paginate through collections of data by setting the cursor parameter to a next_cursor attribute returned by a previous request's response_metadata. Default value fetches the first 'page' of the collection. See pagination for more detail."
    c.flag 'include_locale', desc: 'Set this to true to receive the locale for users. Defaults to false.'
    c.flag 'limit', desc: "The maximum number of items to return. Fewer than the requested number of items may be returned, even if the end of the users list hasn't been reached. Providing no limit value will result in Slack attempting to deliver you the entire result set. If the collection is too large you may experience limit_required or HTTP 500 errors."
    c.action do |_global_options, options, _args|
      puts JSON.dump($client.users_list(options))
    end
  end

  g.desc 'Find a user with an email address.'
  g.long_desc %( Find a user with an email address. )
  g.command 'lookupByEmail' do |c|
    c.flag 'email', desc: 'An email address belonging to a user in the workspace.'
    c.action do |_global_options, options, _args|
      puts JSON.dump($client.users_lookupByEmail(options))
    end
  end

  g.desc 'This method searches for users.'
  g.long_desc %( This method searches for users. )
  g.command 'search' do |c|
    c.flag 'user', desc: 'User to search for.'
    c.action do |_global_options, options, _args|
      puts JSON.dump($client.users_search(options))
    end
  end

  g.desc 'Marked a user as active. Deprecated and non-functional.'
  g.long_desc %( Marked a user as active. Deprecated and non-functional. )
  g.command 'setActive' do |c|
    c.action do |_global_options, options, _args|
      puts JSON.dump($client.users_setActive(options))
    end
  end

  g.desc 'Set the user profile photo'
  g.long_desc %( Set the user profile photo )
  g.command 'setPhoto' do |c|
    c.flag 'crop_w', desc: 'Width/height of crop box (always square).'
    c.flag 'crop_x', desc: 'X coordinate of top-left corner of crop box.'
    c.flag 'crop_y', desc: 'Y coordinate of top-left corner of crop box.'
    c.flag 'image', desc: 'File contents via multipart/form-data.'
    c.action do |_global_options, options, _args|
      puts JSON.dump($client.users_setPhoto(options))
    end
  end

  g.desc 'Manually sets user presence.'
  g.long_desc %( Manually sets user presence. )
  g.command 'setPresence' do |c|
    c.flag 'presence', desc: 'Either auto or away.'
    c.action do |_global_options, options, _args|
      puts JSON.dump($client.users_setPresence(options))
    end
  end
end
