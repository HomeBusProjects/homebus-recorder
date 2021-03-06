lock "~> 3.14.1"

set :application, 'recorder'
set :repo_url, 'git@github.com:HomeBusProjects/homebus-recorder.git'
set :rbenv_ruby, '2.6.2'

set :whenever_roles, -> { [ :db ] }

current_branch = `git rev-parse --abbrev-ref HEAD`.strip
set :branch, ENV['branch'] || current_branch || "master" 

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

set :deploy_to, '/home/recorder/recorder'

set :format, :airbrussh

append :linked_files, 'config/master.key'
append :linked_files, '.env'
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", '.bundle'

task :update_backup_symlink do
  on roles(:db) do
    execute "rm -f ~/Backup"
    execute "ln -s #{release_path}/backup ~/Backup"
  end
end

before 'whenever:update_crontab', :update_backup_symlink
