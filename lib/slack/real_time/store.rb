module Slack
  module RealTime
    class Store
      attr_accessor :self_id
      attr_accessor :users
      attr_accessor :bots
      attr_accessor :channels
      attr_accessor :groups
      attr_accessor :team
      attr_accessor :ims

      def self
        users[@self_id]
      end

      def initialize(attrs = {})
        @self_id = attrs['self']['id']

        @team = Models::Team.new(attrs['team'])

        # users
        @users = {}
        attrs['users'].each do |data|
          user = Models::User.new(data)
          user.merge!(attrs['self']) if @self_id == user['id']
          @users[data['id']] = user
        end

        {
          'channels' => Models::Channel,
          'bots' => Models::Bot,
          'groups' => Models::Group,
          'ims' => Models::Im
        }.each_pair do |key, klass|
          instance_variable_set "@#{key}", {}
          attrs[key].each do |data|
            instance_variable_get("@#{key}").send(:[]=, data['id'], klass.new(data))
          end
        end
      end
    end
  end
end
