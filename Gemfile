source 'http://rubygems.org'

gemspec

gem ENV['CONCURRENCY'], require: false if ENV.key?('CONCURRENCY')
gem 'picky' unless RUBY_PLATFORM == 'java'
gem 'activesupport', '~> 4.0'
gem 'danger', '~> 2.0'
