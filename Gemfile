# frozen_string_literal: true
source 'http://rubygems.org'

gemspec

if ENV.key?('CONCURRENCY')
  case ENV['CONCURRENCY']
  when 'async-websocket'
    gem 'async-websocket', '~> 0.8.0', require: false
  else
    gem ENV['CONCURRENCY'], require: false
  end
end

group :test do
  gem 'activesupport'
  gem 'erubis'
  gem 'faraday-typhoeus'
  gem 'json-schema'
  gem 'rake', '~> 13'
  gem 'rspec'
  gem 'rubocop', '1.26.1' # Lock to specific version to avoid breaking cops/changes
  gem 'rubocop-performance'
  gem 'rubocop-rake'
  gem 'rubocop-rspec'
  gem 'timecop'
  if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('3.0.0')
    # https://github.com/vcr/vcr/pull/907
    gem 'vcr', github: 'vcr/vcr', ref: '7ac8292c'
  else
    gem 'vcr'
  end
  gem 'webmock'
end
