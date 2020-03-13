# frozen_string_literal: true
# largely from https://github.com/aki017/slack-ruby-gem
require 'json-schema'
require 'erubis'

namespace :slack do
  namespace :real_time do
    namespace :api do
      REAL_TIME_EVENTS_MARKER = '### RealTime Events'

      desc 'Update Real Time API.'
      task update: [:git_update] do
        event_schema = JSON.parse(File.read('lib/slack/real_time/api/schema/event.json'))
        dirglob = 'lib/slack/web/api/slack-api-ref/events/**/*.json'
        events = Dir.glob(dirglob).each_with_object({}) do |path, result|
          name = File.basename(path, '.json')
          parsed = JSON.parse(File.read(path))
          JSON::Validator.validate(event_schema, parsed, insert_defaults: true)
          next if %w[message hello].include?(name)

          result[name] = parsed
        end

        event_handler_template =
          Erubis::Eruby.new(File.read('lib/slack/real_time/api/templates/event_handler.erb'))
        Dir.glob('lib/slack/real_time/stores/**/*.rb').each do |store_file|
          next if File.basename(store_file) == 'base.rb'

          STDOUT.write "#{File.basename(store_file)}:"

          store_file_contents = File.read(store_file)

          events.each_pair do |event_name, event_data|
            if store_file_contents.include?("on :#{event_name} do")
              STDOUT.write('.')
            else
              STDOUT.write('x')
              rendered_event_handler = event_handler_template.result(
                name: event_data['name'],
                desc: event_data['desc']
              )

              store_file_contents.gsub!(
                REAL_TIME_EVENTS_MARKER,
                REAL_TIME_EVENTS_MARKER +
                  "\n\n" +
                  rendered_event_handler.rstrip
              )
            end
          end

          File.open store_file, 'w' do |f|
            f.write store_file_contents
          end

          puts ' done.'
        end
      end
    end
  end
end
