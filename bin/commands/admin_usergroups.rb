# frozen_string_literal: true
# This file was auto-generated by lib/tasks/web.rake

desc 'AdminUsergroups methods.'
command 'admin_usergroups' do |g|
  g.desc 'Add one or more default channels to an IDP group.'
  g.long_desc %( Add one or more default channels to an IDP group. )
  g.command 'addChannels' do |c|
    c.flag 'channel_ids', desc: 'Comma separated string of channel IDs.'
    c.flag 'team_id', desc: 'The workspace to add default channels in.'
    c.flag 'usergroup_id', desc: 'ID of the IDP group to add default channels for.'
    c.action do |_global_options, options, _args|
      puts JSON.dump($client.admin_usergroups_addChannels(options))
    end
  end

  g.desc 'List the channels linked to an org-level IDP group (user group).'
  g.long_desc %( List the channels linked to an org-level IDP group (user group). )
  g.command 'listChannels' do |c|
    c.flag 'usergroup_id', desc: 'ID of the IDP group to list default channels for.'
    c.flag 'include_num_members', desc: 'Flag to include or exclude the count of members per channel.'
    c.flag 'team_id', desc: 'ID of the the workspace.'
    c.action do |_global_options, options, _args|
      puts JSON.dump($client.admin_usergroups_listChannels(options))
    end
  end

  g.desc 'Remove one or more default channels from an org-level IDP group (user group).'
  g.long_desc %( Remove one or more default channels from an org-level IDP group (user group). )
  g.command 'removeChannels' do |c|
    c.flag 'channel_ids', desc: 'Comma-separated string of channel IDs.'
    c.flag 'usergroup_id', desc: 'ID of the IDP Group.'
    c.action do |_global_options, options, _args|
      puts JSON.dump($client.admin_usergroups_removeChannels(options))
    end
  end
end
