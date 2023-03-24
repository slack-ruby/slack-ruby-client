# frozen_string_literal: true
module Slack
  module Messages
    module Formatting
      class << self
        #
        # Unescape a message.
        # @see https://api.slack.com/docs/formatting
        #
        def unescape(message)
          CGI.unescapeHTML(message.gsub(/[“”]/, '"')
            .gsub(/[‘’]/, "'")
            .gsub(/<(?<sign>[?@#!]?)(?<dt>.*?)>/) do
              sign = Regexp.last_match[:sign]
              dt = Regexp.last_match[:dt]
              rhs = dt.split('|', 2).last
              case sign
              when '@', '!'
                "@#{rhs}"
              when '#'
                "##{rhs}"
              else
                rhs
              end
            end)
        end

        #
        # Escape a message.
        # @see https://api.slack.com/reference/surfaces/formatting#escaping
        #
        def escape(message)
          message
            .gsub('&', '&amp;')
            .gsub('>', '&gt;')
            .gsub('<', '&lt;')
        end
      end
    end
  end
end
