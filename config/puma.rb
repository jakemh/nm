# config/puma.rb
threads 1, 6
workers 2
daemonize true

root = "/home/nm/www/shared"
working_directory = "/home/nm/www/current"
pidfile "#{root}/tmp/pids/puma.pid"

railsenv = 'production'
directory working_directory
environment railsenv
state_path "#{root}/tmp/pids/puma.state"
stdout_redirect
"#{working_directory}/log/puma-#{railsenv}.stdout.log",
"#{working_directory}/log/puma-#{railsenv}.stderr.log"
bind "unix:///tmp/next_mission.sock"