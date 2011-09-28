class CreateHackTags < ActiveRecord::Migration
  def self.up
    create_table :hack_tags do |t|
      t.string :name
      t.string :image_url

      t.timestamps
    end
  end

  def self.down
    drop_table :hack_tags
  end
end
