source 'http://rubygems.org'

gemspec

concurrency = ENV['CONCURRENCY']

gem 'faye-websocket', require: false, install_if: concurrency == 'eventmachine'
gem 'celluloid-io', require: false, install_if: concurrency == 'celluloid'

group :development, :test do
  gem 'rubocop'
end

gem 'pry-byebug'
