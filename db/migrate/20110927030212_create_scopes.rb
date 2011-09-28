class CreateScopes < ActiveRecord::Migration
  def self.up
    create_table :scopes do |t|
      t.string :image_url

      t.timestamps
    end
  end

  def self.down
    drop_table :scopes
  end
end
