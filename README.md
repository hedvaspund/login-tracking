
apache web server should run on port 80
add virtual hosts for : login-tracking.com to apache conf files
set your /etc/hosts file with the host name

# pre instal:
run bundler
bundle exec rake db:create 
bundle exec rake db:migrate
# run tracker server
bundle exec ruby tracker_server.rb
# run login tracker
bundle exec ruby lib/logged_in_users.rb