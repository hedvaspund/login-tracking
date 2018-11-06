require_relative 'login_tracker'


logged_users = LoginTracker::Operation.track_logged_in_users
STDERR.puts "logged_users:"

logged_users.each do |username|
  STDERR.puts "*"* 100
  STDERR.puts username
end