# config valid only for Capistrano 3.1
lock '3.1.0'

## Server settings
set :deploy_to, "/home/ubuntu/my_application"
set :rails_env, 'development'
set :deploy_via, :copy

## Repo settings
set :scm, :git
set :repo_url, 'git@github.com:aldazj/Platform_am_v2.git'

set :linked_dirs, %w{tmp/pids tmp/sockets log}

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :stages, ['staging', 'production', 'development']
set :default_stage, 'staging'

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
       execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  desc 'Create dataBase'
  task :createDatabase => :environment do
    print "  ------------>>>>>>>>>>>>>>><< creating   A A A A A A  A A A  A A.\n"
    run 'mkdir kakaaaaaaa'
    run "cd #{current_path}/am/ && bundle exec rake #{ENV['db:create:all']}"
    #RAILS_ENV=#{rails_env}
  end

  desc 'Migrate dataBase'
  task :migrateDatabase do
    run "cd #{current_path}/am/ && bundle exec rake #{ENV['db:migrate']}"
  end

  desc 'Runs rake db:seed for SeedMigrations data'
  task :seedDatabase do
    run "cd #{current_path}/am/ && bundle exec rake #{ENV['db:seed']} "
  end
end

after 'deploy:createDatabase', 'deploy:migrateDatabase'
after 'deploy:migrateDatabase', 'deploy:seedDatabase'