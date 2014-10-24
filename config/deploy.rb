# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'NextMission'
set :repo_url, "git@github.com:nextmission/nextmission-core.git"
# set :repository,  "/Users/jh/Developer/NextMission/.git"
# set :local_repository, "/Users/jh/Developer/NextMission/.git"
set :deploy_to, '/home/nm/www/'
set :deploy_via, :copy
set :puma_pid, '/home/oli/www/shared/tmp/pids/puma.pid'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

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

namespace :deploy do
  def root
    "/home/nm/www/shared"
  end

  def working_directory
    "/home/nm/www/current"
  end

  def puma_pid
    root + "/tmp/pids/puma.pid"
  end 

  set :app_name, "NextMission"

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  desc 'Start Puma'
  task :start do
    on roles(:web) do
      within current_path do
          execute :bundle, "exec puma -e production -S ~/puma -C config/puma.rb -b unix:///tmp/next_mission.sock"
        end
    end
  end

  task :restart_puma do
    on roles(:web) do
      within current_path do
          puts "RESTARTING PUMA"
          execute "kill -s USR2 `cat #{puma_pid}`"
        end
    end
  end

  desc "Symlink application.yml to the release path"
  task :finalize do
    on roles(:web) do
      within current_path do
        puts "SYM LINKING"
        execute "ln -sf #{root}/application.yml #{working_directory}/config/application.yml"
      end
    end

  end

  after :publishing, :restart_puma
  after :restart_puma, :finalize
  after :finalize, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
