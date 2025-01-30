# frozen_string_literal: true
# This file was auto-generated by lib/tasks/web.rake

module Slack
  module Cli
    class App
      desc 'Usergroups methods.'
      command 'usergroups' do |g|
        g.desc 'Create a User Group.'
        g.long_desc %( Create a User Group. )
        g.command 'create' do |c|
          c.flag 'name', desc: 'A name for the User Group. Must be unique among User Groups.'
          c.flag 'channels', desc: 'A comma separated string of encoded channel IDs for which the User Group uses as a default.'
          c.flag 'description', desc: 'A short description of the User Group.'
          c.flag 'handle', desc: 'A mention handle. Must be unique among channels, users and User Groups.'
          c.flag 'include_count', desc: 'Include the number of users in each User Group.'
          c.flag 'team_id', desc: 'Encoded team id where the user group has to be created, required if org token is used.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.usergroups_create(options))
          end
        end

        g.desc 'Disable an existing User Group.'
        g.long_desc %( Disable an existing User Group. )
        g.command 'disable' do |c|
          c.flag 'usergroup', desc: 'The encoded ID of the User Group to disable.'
          c.flag 'include_count', desc: 'Include the number of users in the User Group.'
          c.flag 'team_id', desc: 'Encoded target team id where the user group is, required if org token is used.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.usergroups_disable(options))
          end
        end

        g.desc 'Enable a User Group.'
        g.long_desc %( Enable a User Group. )
        g.command 'enable' do |c|
          c.flag 'usergroup', desc: 'The encoded ID of the User Group to enable.'
          c.flag 'include_count', desc: 'Include the number of users in the User Group.'
          c.flag 'team_id', desc: 'Encoded team id where the user group is, required if org token is used.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.usergroups_enable(options))
          end
        end

        g.desc 'List all User Groups for a team.'
        g.long_desc %( List all User Groups for a team. )
        g.command 'list' do |c|
          c.flag 'include_count', desc: 'Include the number of users in each User Group.'
          c.flag 'include_disabled', desc: 'Include disabled User Groups.'
          c.flag 'include_users', desc: 'Include the list of users for each User Group.'
          c.flag 'team_id', desc: 'encoded team id to list user groups in, required if org token is used.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.usergroups_list(options))
          end
        end

        g.desc 'Update an existing User Group.'
        g.long_desc %( Update an existing User Group. )
        g.command 'update' do |c|
          c.flag 'usergroup', desc: 'The encoded ID of the User Group to update.'
          c.flag 'channels', desc: 'A comma separated string of encoded channel IDs for which the User Group uses as a default.'
          c.flag 'description', desc: 'A short description of the User Group.'
          c.flag 'handle', desc: 'A mention handle. Must be unique among channels, users and User Groups.'
          c.flag 'include_count', desc: 'Include the number of users in the User Group.'
          c.flag 'name', desc: 'A name for the User Group. Must be unique among User Groups.'
          c.flag 'team_id', desc: 'encoded team id where the user group exists, required if org token is used.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.usergroups_update(options))
          end
        end
      end
    end
  end
end
