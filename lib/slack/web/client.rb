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
    end
  end
end
