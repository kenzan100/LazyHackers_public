class AddJustForDataImportToManyTables < ActiveRecord::Migration
  def self.up
    add_column :progres, :start_time, :time
    add_column :progres, :graduated, :boolean
    add_column :progres, :dropout, :boolean
    
    add_column :hack_tags, :duration, :integer
    add_column :hack_tags, :category_flag, :boolean
    add_column :hack_tags, :picture_flag, :boolean
    add_column :hack_tags, :created_by, :integer
  end

  def self.down
    remove_column :progres, :dropout
    remove_column :progres, :graduated
    remove_column :progres, :start_time

    remove_column :hack_tags, :duration, :integer
    remove_column :hack_tags, :category_flag, :boolean
    remove_column :hack_tags, :picture_flag, :boolean
    remove_column :hack_tags, :created_by, :integer
  end
end
