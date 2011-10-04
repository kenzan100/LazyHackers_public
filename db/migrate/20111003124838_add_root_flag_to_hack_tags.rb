class AddRootFlagToHackTags < ActiveRecord::Migration
  def self.up
    add_column :hack_tags, :root_flag, :boolean
  end

  def self.down
    remove_column :hack_tags, :root_flag
  end
end
