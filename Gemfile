source 'http://rubygems.org'

gemspec

case ENV['CONCURRENCY']
when 'eventmachine' then
  gem 'eventmachine'
  gem 'faye-websocket'
when 'faye' then
  gem 'faye-websocket'
when 'celluloid' then
  gem 'celluloid-io'
end
