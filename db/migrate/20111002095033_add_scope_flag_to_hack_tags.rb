class AddScopeFlagToHackTags < ActiveRecord::Migration
  def self.up
    add_column :hack_tags, :singled_by, :integer
  end

  def self.down
    remove_column :hack_tags, :singled_by
  end
end
