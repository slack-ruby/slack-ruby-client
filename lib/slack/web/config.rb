module Slack
  module Web
    module Config
      extend self

      ATTRIBUTES = [
        :proxy,
        :user_agent,
        :ca_path,
        :ca_file,
        :logger,
        :endpoint,
        :token
      ].freeze

      attr_accessor(*Config::ATTRIBUTES)

      def reset
        self.endpoint = 'https://slack.com/api/'
        self.user_agent = "Slack Ruby Client/#{Slack::VERSION}"
        self.ca_path = `openssl version -a | grep OPENSSLDIR | awk '{print $2}'|sed -e 's/\"//g'`
        self.ca_file = "#{ca_path}/ca-certificates.crt"
        self.token = nil
        self.proxy = nil
        self.logger = nil
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
end

Slack::Web::Config.reset
