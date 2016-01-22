module Slack
  module Web
    module Api
      module Mixins
        module User
          def get_user_id(name)
            return name unless name[0] == '@'
            users_list.tap do |list|
              list['members'].each do |user|
                return user['id'] if user['name'] == name[1..-1]
              end
            end
            nil
          end
        end
      end
    end
  end
end
