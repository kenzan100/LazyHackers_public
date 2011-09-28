class CreateUsersScopes < ActiveRecord::Migration
  def self.up
    create_table :users_scopes do |t|
      t.integer :user_id
      t.integer :scope_id

      t.timestamps
    end
  end

  def self.down
    drop_table :users_scopes
  end
end
