# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
# Don't declare `role :all`, it's a meta role
role :app, %w{saalonmuyo.com}
role :web, %w{saalonmuyo.com}
role :db,  %w{saalonmuyo.com}

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.
server 'saalonmuyo.com', user: 'deploy', roles: %w{web app db}

# you can set custom ssh options
# it's possible to pass any option but you need to keep in mind that net/ssh understand limited list of options
# you can see them in [net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start)
# set it globally
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
# and/or per server
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
# setting per server overrides global ssh_options
# this should match the filename. E.g. if this is production.rb,
# this should be: production
set :stage, :staging
set :branch, "master"

# used in case we're deploying multiple versions of the same
# app side by side. Also provides quick sanity checks when looking
# at file paths
set :full_app_name, "#{fetch(:application)}_#{fetch(:stage)}"

set :deploy_to, "/srv/www/#{fetch(:full_app_name)}"
# don't try and infer some thing as important as environment from
# stage name.
set :rails_env, :production

# number of unicorn workers, this will be reflected in
# the unicorn.rb and the monit configs
set :unicorn_worker_count, 2

# whether we're using ssl or not, used for building nginx
# config file
set :enable_ssl, false

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