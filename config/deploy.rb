# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'seanchai'

# setup repo details
set :scm, :git
set :repo_url, 'git@github.com:daemonsongproductions/Seanchai.git'

# setup rvm.
set :rbenv_type, :system
set :rbenv_ruby, '2.0.0-p0'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/srv/www/seanchai'

# how many old releases do we want to keep
set :keep_releases, 5

# files we want symlinking to specific entries in shared.
set :linked_files, %w{config/mongoid.yml config/application.yml}

# dirs we want symlinking to shared
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# which config files should be copied by deploy:setup_config
# see documentation in lib/capistrano/tasks/setup_config.cap
# for details of operations
set(:config_files, %w(
  nginx.conf
  application.yml
  mongoid.yml
  log_rotation
  unicorn.rb
  unicorn_init.sh
))

# which config files should be made executable after copying
# by deploy:setup_config
set(:executable_config_files, %w(
  unicorn_init.sh
))

# files which need to be symlinked to other parts of the
# filesystem. For example nginx virtualhosts, log rotation
# init scripts etc.
set(:symlinks, [
    {
        source: "nginx.conf",
        link: "/etc/nginx/sites-enabled/#{fetch(:full_app_name)}"
    },
    {
        source: "unicorn_init.sh",
        link: "/etc/init.d/unicorn_#{fetch(:full_app_name)}"
    },
    {
        source: "log_rotation",
        link: "/etc/logrotate.d/#{fetch(:full_app_name)}"
    },
])

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


# this:
# http://www.capistranorb.com/documentation/getting-started/flow/
# is worth reading for a quick overview of what tasks are called
# and when for `cap stage deploy`

namespace :deploy do
  # make sure we're deploying what we think we're deploying
  before :deploy, "deploy:check_revision"
  # compile assets locally then rsync
  after 'deploy:symlink:shared', 'deploy:compile_assets_locally'
  after :finishing, 'deploy:cleanup'
end

desc "Check that we can access everything"
task :check_write_permissions do
  on roles(:all) do |host|
    if test("[ -w #{fetch(:deploy_to)} ]")
      info "#{fetch(:deploy_to)} is writable on #{host}"
    else
      error "#{fetch(:deploy_to)} is not writable on #{host}"
    end
  end
end

# lib/capistrano/tasks/agent_forwarding.cap
desc "Check if agent forwarding is working"
task :forwarding do
  on roles(:all) do |h|
    if test("env | grep SSH_AUTH_SOCK")
      info "Agent forwarding is up to #{h}"
    else
      error "Agent forwarding is NOT up to #{h}"
    end
  end
end

namespace :assets do
  before :backup_manifest, 'deploy:assets:create_manifest_json'
  task :create_manifest_json do
    on roles :web do
      within release_path do
        execute :mkdir, release_path.join('assets_manifest_backup')
      end
    end
  end
end
