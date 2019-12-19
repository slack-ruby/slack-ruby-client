# frozen_string_literal: true
module Slack
  module Web
    module Api
      module Errors
        SlackError = Class.new(Faraday::Error)
      end
    end
  end
end
