module Slack
  module Web
    module Api
      module Options
        def encode_options(group, options)
          case group
          when 'chat'
            options = encode_json(options, :attachments)
            encode_json(options, :blocks)
          when 'views'
            encode_json(options, :view)
          when 'dialog'
            encode_json(options, :dialog)
          else
            options
          end
        end

        private

        def encode_json(options, key)
          if options.key?(key) && !options[key].is_a?(String)
            option = JSON.dump(options[key])
            options.merge(key => option)
          else
            options
          end
        end
      end
    end
  end
end
