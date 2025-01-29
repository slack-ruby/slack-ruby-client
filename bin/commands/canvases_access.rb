# frozen_string_literal: true
# This file was auto-generated by lib/tasks/web.rake

module Slack
  module Cli
    class App
      desc 'CanvasesAccess methods.'
      command 'canvases_access' do |g|
        g.desc 'Remove access to a canvas for specified entities'
        g.long_desc %( Remove access to a canvas for specified entities )
        g.command 'delete' do |c|
          c.flag 'canvas_id', desc: 'Encoded ID of the canvas.'
          c.flag 'channel_ids', desc: 'List of channels you wish to update access for.'
          c.flag 'user_ids', desc: 'List of users you wish to update access for.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.canvases_access_delete(options))
          end
        end

        g.desc 'Sets the access level to a canvas for specified entities'
        g.long_desc %( Sets the access level to a canvas for specified entities )
        g.command 'set' do |c|
          c.flag 'access_level', desc: 'Desired level of access.'
          c.flag 'canvas_id', desc: 'Encoded ID of the canvas.'
          c.flag 'channel_ids', desc: 'List of channels you wish to update access for. Can only be used if user_ids is not provided.'
          c.flag 'user_ids', desc: 'List of users you wish to update access for. Can only be used if channel_ids is not provided.'
          c.action do |_global_options, options, _args|
            puts JSON.dump(@client.canvases_access_set(options))
          end
        end
      end
    end
  end
end
