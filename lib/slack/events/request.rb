module Slack
  module Events
    class Request
      class MissingSigningSecret < StandardError; end
      class TimestampExpired < StandardError; end
      class InvalidSignature < StandardError; end

      attr_reader :http_request

      def initialize(http_request)
        @http_request = http_request
      end

      # Request timestamp.
      def timestamp
        @timestamp ||= http_request.headers['X-Slack-Request-Timestamp']
      end

      # The signature is created by combining the signing secret with the body of the request
      # Slack is sending using a standard HMAC-SHA256 keyed hash.
      def signature
        @signature ||= http_request.headers['X-Slack-Signature']
      end

      # Signature version.
      def version
        'v0'
      end

      # Request body.
      def body
        @body ||= http_request.body.read
      end

      # Returns true if the signature coming from Slack has expired.
      def expired?
        timestamp.nil? || (Time.now.to_i - timestamp.to_i).abs > Slack::Events.config.signature_expires_in
      end

      # Returns true if the signature coming from Slack is valid.
      def valid?
        raise MissingSigningSecret unless Slack::Events.config.signing_secret

        digest = OpenSSL::Digest::SHA256.new
        signature_basestring = [version, timestamp, body].join(':')
        hex_hash = OpenSSL::HMAC.hexdigest(digest, Slack::Events.config.signing_secret, signature_basestring)
        computed_signature = [version, hex_hash].join('=')
        computed_signature == signature
      end

      # Validates the request signature and its expiration.
      def verify!
        raise TimestampExpired if expired?
        raise InvalidSignature unless valid?

        true
      end
    end
  end
end
