# frozen_string_literal: true

require 'ruby-gem-release/changelog'
require 'ruby-gem-release/markdown/section'
require 'ruby-gem-release/workflow/ruby_gem'

# Builds the ruby-gem-release workflow used by the Rakefile, the Release GitHub Actions workflow, and spec/release.
module SlackRubyClientRelease
  UPGRADING = 'See [UPGRADING](UPGRADING.md) when upgrading from an older version.'

  def self.workflow(**options)
    workflow = RubyGemRelease::Workflow::RubyGem.new(
      version: RubyGemRelease::Version::RubyConstant.new(path: 'lib/slack/version.rb', constant: 'VERSION'),
      changelog: RubyGemRelease::Changelog::Intridea.new(placeholder: '* Your contribution here.'),
      **options
    )
    readme = RubyGemRelease::Markdown::Section.new(path: 'README.md', heading: '## Stable Release')
    workflow.before(:validate) { |_ctx| readme.validate! }
    workflow.after(:prepare_release) { |ctx| readme.replace!(stable(ctx.release.version)) }
    workflow.after(:prepare_next) { |ctx| readme.replace!(development(ctx.release.version)) }
    workflow
  end

  def self.stable(version)
    "You're reading the documentation for the **stable** release of slack-ruby-client, #{version}. #{UPGRADING}"
  end

  def self.development(version)
    "You're reading the documentation for the **next** release of slack-ruby-client. Please see the documentation for the " \
      "[last stable release, v#{version}](https://github.com/slack-ruby/slack-ruby-client/blob/v#{version}/README.md) " \
      "unless you're integrating with HEAD. #{UPGRADING}"
  end
end
