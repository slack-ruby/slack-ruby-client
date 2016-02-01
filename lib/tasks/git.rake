namespace :slack do
  # update slack-api-ref from https://github.com/dblock/slack-api-ref
  task :git_update do
    sh 'git submodule update --init --recursive'
    sh 'git submodule foreach git pull origin master'
  end
end
