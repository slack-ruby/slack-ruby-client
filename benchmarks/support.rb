# frozen_string_literal: true

# Shared setup for the benchmarks in this directory. Run one with
# `bundle exec ruby benchmarks/<name>.rb`, or all of them with `bundle exec rake benchmark`.
# Set BENCHMARK_TIME and BENCHMARK_WARMUP (seconds) to trade accuracy for speed.

require 'benchmark/ips'
require 'benchmark/memory'
require 'json'

require_relative '../lib/slack-ruby-client'

module SlackBenchmarks
  # A Faraday adapter that answers every request in process from canned JSON,
  # so benchmarks measure the client stack (middleware, JSON, Hashie::Mash, helpers) without network noise.
  class Adapter < Faraday::Adapter
    class << self
      attr_accessor :responder
    end

    def call(env)
      super
      body = self.class.responder.call(env)
      save_response(env, 200, body, { 'Content-Type' => 'application/json; charset=utf-8' })
      @app.call(env)
    end
  end

  module_function

  def run(title, &block)
    puts "== #{title} (Ruby #{RUBY_VERSION}, slack-ruby-client #{Slack::VERSION})"
    time = Float(ENV.fetch('BENCHMARK_TIME', 2))
    warmup = Float(ENV.fetch('BENCHMARK_WARMUP', 1))
    Benchmark.ips do |x|
      x.config(time: time, warmup: warmup)
      yield x
    end
    Benchmark.memory(&block)
  end

  def client(&responder)
    Adapter.responder = responder
    Slack::Web::Client.new(token: 'benchmark-token', adapter: Adapter, logger: ::Logger.new(nil))
  end

  def members(count, prefix: 'U')
    Array.new(count) do |i|
      {
        id: "#{prefix}#{i.to_s.rjust(8, '0')}",
        name: "user#{i}",
        real_name: "User #{i}",
        profile: { email: "user#{i}@example.com", display_name: "user#{i}", image: "https://example.com/#{i}.png" }
      }
    end
  end

  # Pages through `items` like a cursor-paginated Slack method, honoring `limit` and `cursor`.
  def paginate(env, key, items)
    params = env.method == :get ? Faraday::Utils.parse_query(env.url.query.to_s) : Faraday::Utils.parse_query(env.request_body.to_s)
    limit = Integer(params['limit'] || 100)
    offset = Integer(params['cursor'].to_s.empty? ? 0 : params['cursor'])
    page = items[offset, limit] || []
    next_cursor = offset + limit < items.size ? (offset + limit).to_s : ''
    JSON.dump(ok: true, key => page, response_metadata: { next_cursor: next_cursor })
  end
end
