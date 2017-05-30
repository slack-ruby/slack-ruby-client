module Slack
  module Config
    extend self

    attr_accessor :token
    attr_accessor :logger
    attr_accessor :timeout
    attr_accessor :open_timeout

    def reset
      self.token = nil
      self.logger = nil
      self.timeout = nil
      self.open_timeout = nil
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
