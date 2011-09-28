class CreateProgres < ActiveRecord::Migration
  def self.up
    create_table :progres do |t|
      t.boolean :success
      t.integer :hack_tag_id
      t.integer :user_id
      t.datetime :done_when

      t.timestamps
    end
  end

  def self.down
    drop_table :progres
  end
end
