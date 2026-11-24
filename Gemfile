# frozen_string_literal: true
source 'http://rubygems.org'

gemspec

group :test do
  gem 'activesupport'
  gem 'base64'
  gem 'bigdecimal'
  gem 'danger-changelog', require: false
  gem 'danger-pr-comment', require: false
  gem 'danger-toc', require: false
  gem 'erubis'
  gem 'faraday-typhoeus'
  gem 'gli'
  gem 'json-schema'
  gem 'mutex_m'
  gem 'racc'
  gem 'rackup', '~> 2.1'
  gem 'rake', '~> 13'
  gem 'rspec'
  # Lock below 1.1.0, which started writing float timestamps to
  # coverage/.resultset.json, breaking coverallsapp/github-action's parser
  # (coverallsapp/github-action#269, coverallsapp/coverage-reporter#191).
  gem 'simplecov', '< 1.1.0'
  gem 'simplecov-lcov'
  gem 'timecop'
  gem 'vcr'
  gem 'webmock'
  gem 'webrick', '~> 1.8'
end

if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('3.2')
  group :lint do
    gem 'rubocop', '~> 1.92'
    gem 'rubocop-exception_messages', '~> 0.2.0', require: false
    gem 'rubocop-md', '~> 3.0', require: false
    gem 'rubocop-performance', '~> 1.27', require: false
    gem 'rubocop-prose', '~> 0.2', require: false
    gem 'rubocop-rake', '~> 0.7', require: false
    gem 'rubocop-rspec', '~> 3.10', require: false
    gem 'rubocop-spellcheck', '~> 0.2', require: false
    gem 'rubocop-yaml', '~> 0.1.0', require: false
  end
end

if RUBY_ENGINE == 'ruby' && Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('3.3')
  group :development do
    gem 'commonmarker', '~> 2.10', require: false
    gem 'ruby-gem-release', '0.9.0', require: false
  end
end
