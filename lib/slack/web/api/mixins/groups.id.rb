module Slack
  module Web
    module Api
      module Mixins
        module Groups
          #
          # This method returns a group ID given a group name.
          #
          # @option options [channel] :channel
          #   Group channel to get ID for, prefixed with #.
          def groups_id(options = {})
            name = options[:channel]
            throw ArgumentError.new('Required arguments :channel missing') if name.nil?
            return { 'ok' => true, 'group' => { 'id' => name } } unless name[0] == '#'
            groups_list.tap do |list|
              list.groups.each do |group|
                return Slack::Messages::Message.new('ok' => true, 'group' => { 'id' => group.id }) if group.name == name[1..-1]
              end
            end
            fail Slack::Web::Api::Error, 'channel_not_found'
          end
        end
      end
    end
  end
end
