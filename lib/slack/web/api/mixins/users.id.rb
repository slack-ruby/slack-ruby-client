module Slack
  module Web
    module Api
      module Mixins
        module Users
          #
          # This method returns a user ID given a user name.
          #
          # @option options [user] :user
          #   User to get ID for, prefixed with '@'.
          def users_id(options = {})
            name = options[:user]
            throw ArgumentError.new('Required arguments :user missing') if name.nil?
            return { 'ok' => true, 'user' => { 'id' => name } } unless name[0] == '@'
            users_list.tap do |list|
              list.members.each do |user|
                return Slack::Messages::Message.new('ok' => true, 'user' => { 'id' => user.id }) if user.name == name[1..-1]
              end
            end
            fail Slack::Web::Api::Error, 'user_not_found'
          end
        end
      end
    end
  end
end
