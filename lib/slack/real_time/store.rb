module Slack
  module RealTime
    class Store
      attr_accessor :users
      attr_accessor :bots
      attr_accessor :channels
      attr_accessor :groups
      attr_accessor :teams
      attr_accessor :ims

      def self
        users[@self_id]
      end

      def team
        teams[@team_id]
      end

      def initialize(attrs)
        if attrs.team
          @team_id = attrs.team.id
          @teams = { @team_id => Models::Team.new(attrs.team) }
        else
          @teams = {}
        end

        {
          'users' => Models::User,
          'channels' => Models::Channel,
          'bots' => Models::Bot,
          'groups' => Models::Group,
          'ims' => Models::Im
        }.each_pair do |key, klass|
          instance_variable_set "@#{key}", {}
          attrs[key].each do |data|
            instance_variable_get("@#{key}").send(:[]=, data.id, klass.new(data))
          end if attrs.key?(key)
        end

        if attrs.self
          @self_id = attrs.self.id
          @users[@self_id].merge!(attrs.self)
        end
      end
    end
  end
end
