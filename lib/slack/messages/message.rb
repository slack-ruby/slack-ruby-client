module Slack
  module Messages
    class Message < Hashie::Mash
      def presence
        super['presence']
      end

      def to_s
        keys.sort_by(&:to_s).map do |key|
          "#{key}=#{self[key]}"
        end.join(', ')
      end
    end
  end
end
