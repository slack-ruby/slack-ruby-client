# frozen_string_literal: true
# This file was auto-generated by lib/tasks/web.rake

desc 'Api methods.'
command 'api' do |g|
  g.desc 'Checks API calling code.'
  g.long_desc %( Checks API calling code. )
  g.command 'test' do |c|
    c.flag 'error', desc: 'Error response to return.'
    c.flag 'foo', desc: 'example property to return.'
    c.action do |_global_options, options, _args|
      puts JSON.dump($client.api_test(options))
    end
  end
end
