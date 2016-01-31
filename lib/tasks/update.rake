namespace :slack do
  namespace :api do
    desc 'Auto-generate automatic portions of the Slack API client.'
    task :update do
      Task['slack:real_time:api:update'].invoke
      Task['slack:web:api:update'].invoke
    end
  end
end
