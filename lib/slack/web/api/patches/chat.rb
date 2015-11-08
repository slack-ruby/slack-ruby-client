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
              attachments = attachments.to_json if !attachments.is_a?(String) && attachments.respond_to?(:to_json)
              options = options.merge(attachments: attachments)
            end
            _chat_postMessage options
          end
        end
      end
    end
  end
end
