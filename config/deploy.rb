set :bundle_cmd,      "/home/xlii/.gem/ruby/1.8/bin/bundle"

require 'bundler/capistrano'
require "#{File.dirname(__FILE__)}/deploy/capistrano_database_yml.rb"

default_run_options[:pty] = true

# be sure to change these
set :user, 'xlii'
set :domain, 'rockit.xlii.com.br'
set :application, 'rockit'

# the rest should be good
set :repository,  "git://github.com/#{user}/#{application}.git"
set :deploy_to, "/home/#{user}/#{domain}"
set :deploy_via, :remote_cache
set :scm, 'git'
set :branch, 'master'
set :git_shallow_clone, 1
set :scm_verbose, true
set :use_sudo, false

server domain, :app, :web
role :db, domain, :primary => true

namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

set :backup_path do
  "#{shared_path}/backup/#{release_name}"
end

namespace :data do
  desc "store a backup of user's data"
  namespace :backup do 
    task :default do
      database
    end
    
    desc "store a database dump (run after update code)"
    task :database, :roles => :db, :only => { :primary => true } do
      run "mkdir -p #{backup_path}"
      filename = "#{backup_path}/mysqldump.sql.bz2"
      text = capture "cat #{deploy_to}/current/config/database.yml"
      yaml = YAML::load(text)

      run "mysqldump -h #{yaml['production']['host']} -u #{yaml['production']['username']} -p #{yaml['production']['database']} | bzip2 -c > #{filename}" do |ch, stream, out|
        ch.send_data "#{yaml['production']['password']}\n" if out =~ /^Enter password:/
      end
    end
  end
end

after "deploy:update_code", "data:backup"
