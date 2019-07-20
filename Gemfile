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
  gem 'danger-toc', '~> 0.1.3', require: false
  gem 'slack-ruby-danger', '~> 0.1.0', require: false
end
