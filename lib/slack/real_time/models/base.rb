module Slack
  module RealTime
    module Models
      class Base < Hashie::Mash
        def presence
          super['presence']
        end
      end
    end
  end
end
