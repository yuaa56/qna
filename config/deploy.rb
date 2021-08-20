# config valid for current version and patch releases of Capistrano
lock "~> 3.16.0"

set :application, "qna"
set :repo_url, "git@github.com:yuaa56/qna.git"

set :rvm_ruby_version, '2.7.1@qna'
# set :passenger_rvm_ruby_version, '2.7.1@qna'

# Default deploy_to directory is /var/www/my_app_name
#set :deploy_to, "/var/www/#{application}"
set :deploy_to, "/home/deployer/qna"
set :deploy_user, "deployer"

# Default value for :linked_files is []
# append :linked_files, "config/database.yml config/cable.yml"
set :linked_files, %w{config/database.yml config/thinking_sphinx.yml .env}
# set :linked_files, %w{config/database.yml config/thinking_sphinx.yml}

# Default value for linked_dirs is []
#append :linked_dirs, "bin", "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system"
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}

# set :passenger_roles, :app # This is the default
# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto


# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

namespace :deploy do
  desc "Restart application"
    task :restart do
        on roles(:app), in: :sequence, wait: 5 do
          # execute :touch, release_path.join('tmp/restart.txt') # для Passenger
          invoke 'unicorn:restart'
        end
    end
    
    after :publishing, :restart
end
