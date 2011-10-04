class CreateUsersHacktags < ActiveRecord::Migration
  def self.up
    create_table :users_hacktags do |t|
      t.integer :user_id
      t.integer :hack_tag_id

      t.timestamps
    end
  end

  def self.down
    drop_table :users_hacktags
  end
end
