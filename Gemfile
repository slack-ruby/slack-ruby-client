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
    gem 'rubocop', '~> 1.72'
    gem 'rubocop-exception_messages', '~> 0.2.0', require: false
    gem 'rubocop-performance', '~> 1.27'
    gem 'rubocop-rake', '~> 0.7'
    gem 'rubocop-rspec', '~> 3.10'
  end
end
