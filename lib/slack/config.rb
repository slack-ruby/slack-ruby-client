require 'slack/logger'

module Slack
  module Config
    extend self

    attr_accessor :token, :logger

    def reset
      self.token = nil
      self.logger = Slack::Logger.default
    end

    reset
  end

  class << self
    def configure
      block_given? ? yield(Config) : Config
    end

    def config
      Config
    end
  end
end
