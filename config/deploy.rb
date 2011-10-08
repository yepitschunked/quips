set :application, "quips"
set :user, "deploy"
set :use_sudo, false
set :repository,  "https://wonnage@github.com/wonnage/quips.git"
set :deploy_to, "/var/rails/#{application}"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "victor-lin.cust.arpnetworks.com"                          # Your HTTP server, Apache/etc
role :app, "victor-lin.cust.arpnetworks.com"                          # This may be the same as your `Web` server
role :db,  "victor-lin.cust.arpnetworks.com", :primary => true # This is where Rails migrations will run
role :db,  "victor-lin.cust.arpnetworks.com"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
