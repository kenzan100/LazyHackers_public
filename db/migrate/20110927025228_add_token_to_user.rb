class AddTokenToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :uid, :integer
    add_column :users, :screen_name, :string
    add_column :users, :access_token, :string
    add_column :users, :access_secret, :string
  end

  def self.down
    remove_column :users, :access_secret
    remove_column :users, :access_token
    remove_column :users, :screen_name
    remove_column :users, :uid
  end
end
