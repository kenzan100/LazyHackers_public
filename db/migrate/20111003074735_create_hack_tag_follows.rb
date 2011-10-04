class CreateHackTagFollows < ActiveRecord::Migration
  def self.up
    create_table :hack_tag_follows do |t|
      t.integer :hack_tag_id
      t.integer :greater_hack_tag_id

      t.timestamps
    end
  end

  def self.down
    drop_table :hack_tag_follows
  end
end
