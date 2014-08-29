# config/puma.rb
threads 1, 6
workers 2

root = "/home/nm/www/shared"
working_directory = "/home/oli/www/current"
pidfile "#{root}/tmp/pids/puma.pid"

on_worker_boot do
  # require "active_record"
  # cwd = File.dirname(__FILE__)+"/.."
  # ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
  # ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"] || YAML.load_file("#{cwd}/config/database.yml")[ENV["RAILS_ENV"]])
end