module Slack
  module RealTime
    module Models
      class Base < Hash
        def initialize(attrs = {})
          attrs.each do |k, v|
            self[k] = v
          end
        end
      end
    end
  end
end
