class AddScopeIdToProgres < ActiveRecord::Migration
  def self.up
    add_column :progres, :scope_id, :integer
  end

  def self.down
    remove_column :progres, :scope_id
  end
end
