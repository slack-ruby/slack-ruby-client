# frozen_string_literal: true
require 'rubygems'
require 'bundler'
require 'bundler/gem_tasks'

Bundler.setup :default, :development

if RUBY_ENGINE == 'ruby' && Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('3.3') &&
   Gem.loaded_specs.key?('ruby-gem-release')
  require_relative 'script/release'
  SlackRubyClientRelease.workflow.install_tasks

  %w[release release:rubygem_push release:source_control_push].each do |name|
    Rake::Task[name].clear
    desc 'Disabled; releases run through GitHub Actions, see RELEASING.md'
    task(name) { abort "#{name} is disabled; releases run through GitHub Actions, see RELEASING.md" }
  end
end

require 'rspec/core'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

desc 'Run RuboCop (Ruby 3.2+).'
task :rubocop do
  abort 'RuboCop requires Ruby 3.2 or newer' if Gem::Version.new(RUBY_VERSION) < Gem::Version.new('3.2')

  sh 'bundle exec rubocop'
end

desc 'Lint Ruby, Markdown, YAML, and spelling (Ruby 3.2+).'
task lint: :rubocop

task default: :spec

load 'tasks/git.rake'
load 'tasks/web.rake'
load 'tasks/update.rake'
