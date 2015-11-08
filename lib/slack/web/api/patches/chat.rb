module Slack
  module Web
    module Api
      module Endpoints
        module Chat
          alias_method :_chat_postMessage, :chat_postMessage
          def chat_postMessage(options = {})
            # attachments must be passed as an encoded JSON string
            if options.key?(:attachments)
              attachments = options[:attachments]
              attachments = JSON.dump(attachments) unless attachments.is_a?(String)
              options = options.merge(attachments: attachments)
            end
            _chat_postMessage options
          end
        end
      end
    end
  end
end
