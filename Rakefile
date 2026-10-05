# frozen_string_literal: true
require 'rubygems'
require 'bundler'
require 'bundler/gem_tasks'

Bundler.setup :default, :development

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

task default: :spec

load 'tasks/git.rake'
load 'tasks/web.rake'
load 'tasks/update.rake'
