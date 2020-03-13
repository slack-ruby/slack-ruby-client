# frozen_string_literal: true
require 'json-schema'
require 'erubis'

namespace :slack do
  namespace :web do
    namespace :api do
      desc 'Update Web API errors from official spec'
      task :update_errors do
        raw_spec = open('https://api.slack.com/specs/openapi/v2/slack_web.json').read
        File.write('lib/slack/web/api/slack-api-spec.json', raw_spec)

        spec = JSON.parse(raw_spec)
        known_typos = %w[
          account_inactiv
          invalid_post_typ
          missing_post_typ
          request_timeou
          token_revokedno_permission
        ]

        errors = spec['paths'].map do |_, path|
          path.map do |_, v|
            v['responses'].map do |_, response|
              response.dig('schema', 'properties', 'error', 'enum')
            end
          end
        end.flatten.compact.uniq.sort

        errors -= known_typos

        errors_template = Erubis::Eruby.new(File.read('lib/slack/web/api/templates/errors.erb'))
        rendered_errors = errors_template.result(errors: errors)
        File.write('lib/slack/web/api/errors.rb', rendered_errors)
      end
    end
  end
end
