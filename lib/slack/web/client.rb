module Slack
  module Web
    class Client
      include Faraday::Connection
      include Faraday::Request
      include Api::Endpoints

      attr_accessor(*Config::ATTRIBUTES)

      def initialize(options = {})
        Slack::Web::Config::ATTRIBUTES.each do |key|
          send("#{key}=", options[key] || Slack::Web.config.send(key))
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
end
