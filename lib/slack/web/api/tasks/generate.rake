# largely from https://github.com/aki017/slack-ruby-gem
require 'json-schema'
require 'erubis'

namespace :slack do
  namespace :web do
    namespace :api do
      # update slack-api-ref from https://github.com/dblock/slack-api-ref
      task :git_update do
        sh 'git submodule update --init --recursive'
        sh 'git submodule foreach git pull origin master'
      end

      desc 'Update API.'
      task update: [:git_update] do
        group_schema = JSON.parse(File.read('lib/slack/web/api/schema/group.json'))
        groups = Dir.glob('lib/slack/web/api/slack-api-ref/groups/**/*.json').each_with_object({}) do |path, result|
          name = File.basename(path, '.json')
          parsed = JSON.parse(File.read(path))
          JSON::Validator.validate(group_schema, parsed, insert_defaults: true)
          result[name] = parsed
        end

        method_schema = JSON.parse(File.read('lib/slack/web/api/schema/method.json'))
        data = Dir.glob('lib/slack/web/api/slack-api-ref/methods/**/*.json').each_with_object({}) do |path, result|
          name = File.basename(path, '.json')
          prefix, name = name.split('.')
          result[prefix] ||= {}
          parsed = JSON.parse(File.read(path))
          JSON::Validator.validate(method_schema, parsed, insert_defaults: true)
          result[prefix][name] = parsed
        end

        method_template = Erubis::Eruby.new(File.read('lib/slack/web/api/templates/method.erb'))
        command_template = Erubis::Eruby.new(File.read('lib/slack/web/api/templates/command.erb'))
        data.each_with_index do |(group, names), index|
          printf "%2d/%2d %10s %s\n", index, data.size, group, names.keys
          # method
          rendered_method = method_template.result(group: group, names: names)
          File.write "lib/slack/web/api/endpoints/#{group}.rb", rendered_method
          Dir.glob("lib/slack/web/api/patches/#{group}*.patch").sort.each do |patch|
            puts "- patching #{patch}"
            system("git apply #{patch}") || fail('failed to apply patch')
          end
          # command
          rendered_command = command_template.result(group: groups[group], names: names)
          File.write "bin/commands/#{group}.rb", rendered_command
        end

        endpoints_template = Erubis::Eruby.new(File.read('lib/slack/web/api/templates/endpoints.erb'))
        File.write 'lib/slack/web/api/endpoints.rb', endpoints_template.result(files: data.keys)

        commands_template = Erubis::Eruby.new(File.read('lib/slack/web/api/templates/commands.erb'))
        File.write 'bin/commands.rb', commands_template.result(files: data.keys)
      end
    end
  end
end
