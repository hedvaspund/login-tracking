class LoginTracks < ActiveRecord::Migration[5.2]
  def change
  	create_table :login_tracks do |t|
      t.string :username,  null: false, default: ""
      t.string :password, null: false, default: ""
      t.datetime :sign_in_at
      t.inet     :sign_in_ip
      t.string   :devise
      t.string   :browser
      t.timestamps
    end

    add_index :login_tracks, :username
  end
end
