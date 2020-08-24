# frozen_string_literal: true
module Slack
  module Web
    module Api
      module Mixins
        module Ids
          private

          def id_for(key, name, prefix, enum_method, list_method, not_found_error)
            return { 'ok' => true, key.to_s => { 'id' => name } } unless name[0] == prefix

            public_send enum_method do |list|
              list.public_send(list_method).each do |li|
                return Slack::Messages::Message.new('ok' => true, key.to_s => { 'id' => li.id }) if li.name == name[1..-1]
              end
            end

            raise Slack::Web::Api::Errors::SlackError, not_found_error
          end
        end
      end
    end
  end
end
