# frozen_string_literal: true
module Slack
  module Web
    module Api
      module Errors
        class ServerError < InternalError; end
        class ParsingError < ServerError; end
        class HttpRequestError < ServerError; end
        class TimeoutError < HttpRequestError; end
        class UnavailableError < HttpRequestError; end
      end
    end
  end
end
