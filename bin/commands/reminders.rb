# frozen_string_literal: true
# This file was auto-generated by lib/tasks/web.rake

module Slack
  module Cli
    class App
      desc 'Reminders methods.'
      command 'reminders' do |g|
        g.desc 'Creates a reminder.'
        g.long_desc %( Creates a reminder. )
        g.command 'add' do |c|
          c.flag 'text', desc: 'The content of the reminder.'
          c.flag 'time', desc: 'Can also take a type of integer. When this reminder should happen: the Unix timestamp (up to five years from now), the number of seconds until the reminder (if within 24 hours), or a natural language description (Ex. "in 15 minutes," or "every Thursday").'
          c.flag 'recurrence', desc: 'Specify the repeating behavior of a reminder. Available options: daily, weekly, monthly, or yearly. If weekly, may further specify the days of the week.'
          c.flag 'team_id', desc: 'Encoded team id, required if org token is used.'
          c.flag 'user', desc: 'No longer supported - reminders cannot be set for other users. Previously, was the user who would receive the reminder.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.reminders_add(options))
          end
        end

        g.desc 'Marks a reminder as complete.'
        g.long_desc %( Marks a reminder as complete. )
        g.command 'complete' do |c|
          c.flag 'reminder', desc: 'The ID of the reminder to be marked as complete.'
          c.flag 'team_id', desc: 'Encoded team id, required if org token is used.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.reminders_complete(options))
          end
        end

        g.desc 'Deletes a reminder.'
        g.long_desc %( Deletes a reminder. )
        g.command 'delete' do |c|
          c.flag 'reminder', desc: 'The ID of the reminder.'
          c.flag 'team_id', desc: 'Encoded team id, required if org token is used.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.reminders_delete(options))
          end
        end

        g.desc 'Gets information about a reminder.'
        g.long_desc %( Gets information about a reminder. )
        g.command 'info' do |c|
          c.flag 'reminder', desc: 'The ID of the reminder.'
          c.flag 'team_id', desc: 'Encoded team id, required if org token is passed.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.reminders_info(options))
          end
        end

        g.desc 'Lists all reminders created by or for a given user.'
        g.long_desc %( Lists all reminders created by or for a given user. )
        g.command 'list' do |c|
          c.flag 'team_id', desc: 'Encoded team id, required if org token is passed.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.reminders_list(options))
          end
        end
      end
    end
  end
end
