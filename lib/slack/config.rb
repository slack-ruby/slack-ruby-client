module Slack
  module Config
    extend self

    attr_accessor :token

    def reset
      self.token = nil
    end
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
