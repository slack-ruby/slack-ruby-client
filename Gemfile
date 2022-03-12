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
  gem 'slack-ruby-danger', '~> 0.2.0', require: false
  if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('3.0.0')
    # https://github.com/vcr/vcr/pull/907
    gem 'vcr', github: 'vcr/vcr', ref: '7ac8292c'
  end
end
