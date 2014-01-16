set :application, 'company_website'
set :repo_url, 'git@bitbucket.org:linhmtran168/company-website.git'

ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, '/var/www/thecompany'
set :scm, :git

set :format, :pretty
set :log_level, :debug
set :pty, true

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}

# set :default_env, :staging
set :rails_env, 'production'
set :keep_releases, 5

set :rbenv_type, :user
set :rbenv_ruby, '2.1.0'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

namespace :deploy do

  desc 'Seed default dabase'
  task :seed => [:set_rails_env] do
    on roles(:db) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:seed"
        end
      end
    end
  end

  desc 'Start application'
  task :start do
    on roles(:app), in: :sequence, wait: 5 do
      execute "/etc/init.d/unicorn_#{fetch(:application)} start"
    end
  end

  desc 'Stop application'
  task :stop do
    on roles(:app), in: :sequence, wait: 5 do
      execute "/etc/init.d/unicorn_#{fetch(:application)} stop"
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
      execute "/etc/init.d/unicorn_#{fetch(:application)} restart"
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      within release_path do
        execute :rake, 'tmp:clear'
      end
    end
  end

  desc 'Setup nginx and unicorn configuration'
  task :setup_config do
    on roles(:app) do
      execute "sudo /bin/ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{fetch(:application)}"
      execute "sudo /bin/ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{fetch(:application)}"
    end
  end

  after :finishing, 'deploy:cleanup'
  after :finished, 'deploy:restart'

end
