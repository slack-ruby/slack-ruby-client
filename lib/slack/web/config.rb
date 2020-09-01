# frozen_string_literal: true
module Slack
  module Web
    module Config
      extend self

      ATTRIBUTES = %i[
        proxy
        user_agent
        ca_path
        ca_file
        logger
        endpoint
        token
        timeout
        open_timeout
        default_page_size
        default_max_retries
        adapter
      ].freeze

      attr_accessor(*Config::ATTRIBUTES)

      def reset
        self.endpoint = 'https://slack.com/api/'
        self.user_agent = "Slack Ruby Client/#{Slack::VERSION}"
        self.ca_path = defined?(OpenSSL) ? OpenSSL::X509::DEFAULT_CERT_DIR : nil
        self.ca_file = defined?(OpenSSL) ? OpenSSL::X509::DEFAULT_CERT_FILE : nil
        self.token = nil
        self.proxy = nil
        self.logger = nil
        self.timeout = nil
        self.open_timeout = nil
        self.default_page_size = 100
        self.default_max_retries = 100
        self.adapter = ::Faraday.default_adapter
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
