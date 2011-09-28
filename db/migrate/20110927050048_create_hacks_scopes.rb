class CreateHacksScopes < ActiveRecord::Migration
  def self.up
    create_table :hacks_scopes do |t|
      t.integer :hack_tag_id
      t.integer :scope_id

      t.timestamps
    end
  end

  def self.down
    drop_table :hacks_scopes
  end
end
