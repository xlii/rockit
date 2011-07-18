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
