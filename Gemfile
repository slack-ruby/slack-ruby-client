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
  gem 'json-schema'
  gem 'mutex_m'
  gem 'racc'
  gem 'rake', '~> 13'
  gem 'rspec'
  gem 'rubocop', '1.26.1' # Lock to specific version to avoid breaking cops/changes
  gem 'rubocop-performance'
  gem 'rubocop-rake'
  gem 'rubocop-rspec'
  # Lock below 1.1.0, which started writing float timestamps to
  # coverage/.resultset.json, breaking coverallsapp/github-action's parser
  # (coverallsapp/github-action#269, coverallsapp/coverage-reporter#191).
  gem 'simplecov', '< 1.1.0'
  gem 'simplecov-lcov'
  gem 'timecop'
  gem 'vcr'
  gem 'webmock'
end
