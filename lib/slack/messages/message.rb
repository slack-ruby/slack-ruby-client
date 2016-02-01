module Slack
  module Messages
    class Message < Hashie::Mash
      def presence
        super['presence']
      end
    end
  end
end
