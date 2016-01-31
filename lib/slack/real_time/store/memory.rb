module Slack
  module RealTime
    module Store
      class Memory
        attr_accessor :self_id
        attr_accessor :users

        def self
          users[@self_id]
        end

        def initialize(attrs = {})
          @self_id = attrs['self']['id']
          @users = {}
          attrs['users'].each do |data|
            user = Models::User.new(data)
            user.merge!(attrs['self']) if @self_id == user['id']
            @users[data['id']] = user
          end
        end
      end
    end
  end
end
