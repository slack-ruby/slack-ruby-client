module Slack
  module Web
    module Api
      module Pagination
        class Cursor
          include Enumerable

          attr_reader :client
          attr_reader :verb
          attr_reader :params

          def initialize(client, verb, params = {})
            @client = client
            @verb = verb
            @params = params
          end

          def each
            next_cursor = nil
            loop do
              query = { limit: client.default_page_size }.merge(params).merge(cursor: next_cursor)
              response = client.send(verb, query)
              yield response
              break unless response.response_metadata
              next_cursor = response.response_metadata.next_cursor
              break if next_cursor.blank?
            end
          end
        end
      end
    end
  end
end
