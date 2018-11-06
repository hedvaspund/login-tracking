require_relative '../app/models/login_track'
require 'pry'
module LoginTracker
  class Operation
    attr_reader :username, :password, :session_id

    def self.invoke(*args)
      get_db_con
      new(*args).invoke
    end

    def initialize(login)
      @username = login["username"]
      @password = login["password"]
      # device
      # ip
      # browser etc.
    end

    def invoke
      track_login
    end

    def self.db_configuration #TBD : move to initializer
      db_configuration_file = File.join(File.expand_path('..', __FILE__), '..', 'db', 'config.yml')
      YAML.load(File.read(db_configuration_file))
    end

    def self.get_db_con
      @get_db_con ||= ActiveRecord::Base.establish_connection(db_configuration["development"])
    end

    def track_login
      LoginTrack.create(username: username, password: password, sign_in_at: Time.now)
    end

    def self.track_list
      get_db_con
      LoginTrack.all.select(:username) # missed session_id &password due to issue
    end

    def self.track_logged_in_users
      user_names = []
      sessions_data = get_db_con.connection.execute("select data from sessions")
      sessions_data.each do |row| 
        crypted_string = row["data"]
        crypt = ActiveSupport::MessageEncryptor.new("258EAFA5-E914-47DA-95CA-C5AB0DC85B11")
        result = crypt.decrypt_and_verify(crypted_string)
        data  = Marshal.load(result)
        user_names << data[:username] 
      end
      user_names.uniq
    end
  end
end

