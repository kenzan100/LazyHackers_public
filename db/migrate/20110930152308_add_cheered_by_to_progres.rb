class AddCheeredByToProgres < ActiveRecord::Migration
  def self.up
    add_column :progres, :cheered_by, :integer
  end

  def self.down
    remove_column :progres, :cheered_by
  end
end
