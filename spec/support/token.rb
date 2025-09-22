# frozen_string_literal: true
RSpec.configure do |config|
  config.before do
    @old_token = Slack::Config.token
  end
  config.after do
    Slack::Config.token = @old_token
    Slack::Web::Config.reset
  end
end
