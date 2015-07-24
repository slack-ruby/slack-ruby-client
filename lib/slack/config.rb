module Slack
  module Config
    extend self

    attr_accessor :token
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
