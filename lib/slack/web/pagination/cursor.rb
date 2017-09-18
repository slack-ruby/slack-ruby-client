module Slack
  module Web
    module Api
      module Pagination
        class Cursor
          include Enumerable

          attr_reader :client
          attr_reader :verb
          attr_reader :sleep_interval
          attr_reader :params

          def initialize(client, verb, params = {})
            @client = client
            @verb = verb
            @sleep_interval = params.delete(:sleep_interval)
            @params = params
          end

          def each
            next_cursor = nil
            loop do
              query = { limit: client.default_page_size }.merge(params).merge(cursor: next_cursor)
              begin
                response = client.send(verb, query)
              rescue Slack::Web::Api::Errors::TooManyRequestsError => e
                sleep(e.retry_after.seconds)
                next
              end
              yield response
              break unless response.response_metadata
              next_cursor = response.response_metadata.next_cursor
              break if next_cursor.blank?
              sleep(sleep_interval) if sleep_interval
            end
          end
        end
      end
    end
  end
end
