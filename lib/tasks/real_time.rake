# largely from https://github.com/aki017/slack-ruby-gem
require 'json-schema'
require 'erubis'

namespace :slack do
  namespace :real_time do
    namespace :api do
      desc 'Update API.'
      task update: [:git_update] do
        event_schema = JSON.parse(File.read('lib/slack/real_time/api/schema/event.json'))
        events = Dir.glob('lib/slack/web/api/slack-api-ref/events/**/*.json').each_with_object({}) do |path, result|
          name = File.basename(path, '.json')
          parsed = JSON.parse(File.read(path))
          JSON::Validator.validate(event_schema, parsed, insert_defaults: true)
          next if %w(message hello).include?(name)
          result[name] = parsed
        end
        # event_handlers.rb
        event_handlers_filename = 'lib/slack/real_time/event_handlers.rb'
        if File.exist?(event_handlers_filename)
          puts "Skipping #{event_handlers_filename}."
        else
          event_handlers_template = Erubis::Eruby.new(File.read('lib/slack/real_time/api/templates/event_handlers.erb'))
          File.write event_handlers_filename, event_handlers_template.result(events: events.keys)
        end
        # each event handler
        event_handler_template = Erubis::Eruby.new(File.read('lib/slack/real_time/api/templates/event_handler.erb'))
        events.each_pair do |name, json|
          event_handler_filename = "lib/slack/real_time/event_handlers/#{name}.rb"
          if File.exist?(event_handler_filename)
            puts "Skipping #{event_handler_filename}."
          else
            puts "Creating #{event_handler_filename}."
            rendered_event_handler = event_handler_template.result(
              name: json['name'],
              class_name: json['name'].split('_').each(&:capitalize!).join,
              desc: json['desc']
            )
            File.write event_handler_filename, rendered_event_handler
          end
        end
      end
    end
  end
end
