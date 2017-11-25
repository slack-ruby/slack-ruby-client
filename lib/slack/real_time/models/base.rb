module Slack
  module RealTime
    module Models
      class Base < Hashie::Mash
        def presence
          super['presence']
        end

        # see https://github.com/intridea/hashie/issues/394
        def log_built_in_message(*); end
      end
    end
  end
end
