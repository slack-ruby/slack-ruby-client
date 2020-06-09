# frozen_string_literal: true
$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'slack/version'

Gem::Specification.new do |s|
  s.name = 'slack-ruby-client'
  s.bindir = 'bin'
  s.executables << 'slack'
  s.version = Slack::VERSION
  s.authors = ['Daniel Doubrovkine']
  s.email = 'dblock@dblock.org'
  s.platform = Gem::Platform::RUBY
  s.required_rubygems_version = '>= 1.3.6'
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ['lib']
  s.homepage = 'http://github.com/slack-ruby/slack-ruby-client'
  s.licenses = ['MIT']
  s.summary = 'Slack Web and RealTime API client.'
  s.add_dependency 'faraday', '>= 1.0'
  s.add_dependency 'faraday_middleware'
  s.add_dependency 'gli'
  s.add_dependency 'hashie'
  s.add_dependency 'websocket-driver'
  s.add_development_dependency 'activesupport'
  s.add_development_dependency 'erubis'
  s.add_development_dependency 'json-schema'
  s.add_development_dependency 'rake', '~> 10'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rubocop', '~> 0.82.0'
  s.add_development_dependency 'rubocop-performance', '~> 1.5.2'
  s.add_development_dependency 'rubocop-rspec', '~> 1.39.0'
  s.add_development_dependency 'timecop'
  s.add_development_dependency 'vcr'
  s.add_development_dependency 'webmock'
end
