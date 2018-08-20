source 'http://rubygems.org'

gemspec

gem ENV['CONCURRENCY'], require: false if ENV.key?('CONCURRENCY')

gem 'activesupport', '~> 4.0'
gem 'picky' unless RUBY_PLATFORM == 'java'

group :test do
  gem 'slack-ruby-danger', '~> 0.1.0', require: false
end
