module Slack
  module RealTime
    module Store
      class Memory
        attr_accessor :users

        def initialize(attrs = {})
          @users = {}
          attrs['users'].each do |data|
            @users[data['id']] = Models::User.new(data)
          end
        end
      end
    end
  end
end
