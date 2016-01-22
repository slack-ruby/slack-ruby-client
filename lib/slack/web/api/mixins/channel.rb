module Slack
  module Web
    module Api
      module Mixins
        module Channel
          def get_channel_id(name)
            return name unless name[0] == '#'
            channels_list.tap do |list|
              list['channels'].each do |channel|
                return channel['id'] if channel['name'] == name[1..-1]
              end
            end
            nil
          end
        end
      end
    end
  end
end
