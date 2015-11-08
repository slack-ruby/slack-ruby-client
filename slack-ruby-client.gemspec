$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'slack/version'

Gem::Specification.new do |s|
  s.name = 'slack-ruby-client'
  s.version = Slack::VERSION
  s.authors = ['Daniel Doubrovkine']
  s.email = 'dblock@dblock.org'
  s.platform = Gem::Platform::RUBY
  s.required_rubygems_version = '>= 1.3.6'
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ['lib']
  s.homepage = 'http://github.com/dblock/slack-ruby-client'
  s.licenses = ['MIT']
  s.summary = 'Slack Web and RealTime API client.'
  s.add_dependency 'faraday'
  s.add_dependency 'faraday_middleware'
  s.add_dependency 'faye-websocket'
  s.add_dependency 'eventmachine'
  s.add_dependency 'json'
  s.add_development_dependency 'erubis'
  s.add_development_dependency 'json-schema'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'vcr'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'rubocop', '0.35.0'
end
