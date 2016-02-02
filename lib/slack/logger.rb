require 'logger'

module Slack
  class Logger < ::Logger

    def self.default
      new(nil)
    end

  end
end
