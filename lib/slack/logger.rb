require 'logger'

module Slack
  class Logger < ::Logger
    def self.default
      new STDOUT
    end
  end
end
