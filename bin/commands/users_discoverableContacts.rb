# frozen_string_literal: true
# This file was auto-generated by lib/tasks/web.rake

module Slack
  module Cli
    class App
      desc 'UsersDiscoverablecontacts methods.'
      command 'users_discoverableContacts' do |g|
        g.desc 'Look up an email address to see if someone is discoverable on Slack'
        g.long_desc %( Look up an email address to see if someone is discoverable on Slack )
        g.command 'lookup' do |c|
          c.flag 'email', desc: '.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.users_discoverableContacts_lookup(options))
          end
        end
      end
    end
  end
end
