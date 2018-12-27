source 'http://rubygems.org'

gemspec

gem ENV['CONCURRENCY'], require: false if ENV.key?('CONCURRENCY')

group :test do
  gem 'slack-ruby-danger', '~> 0.1.0', require: false
end
