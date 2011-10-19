class RemoveTransitionModels < ActiveRecord::Migration
  def self.up
    drop_table :parties_scopes
    drop_table :parties_hacktags
    
    remove_column :hack_tags, :duration
    remove_column :hack_tags, :category_flag
    remove_column :hack_tags, :picture_flag
    
    remove_column :progres, :start_time
    remove_column :progres, :party_id
    
    remove_column :users, :wakeup_time
  end

  def self.down
    create_table :parties_scopes do |t|
      t.integer :party_id
      t.integer :scope_id

      t.timestamps
    end
    
    create_table :parties_hacktags do |t|
      t.integer :party_id
      t.integer :hack_tag_id
    end
    
    add_column :hack_tags, :duration, :integer
    add_column :hack_tags, :category_flag, :boolean
    add_column :hack_tags, :picture_flag, :boolean
    
    add_column :progres, :start_time, :time
    add_column :progres, :party_id, :integer
    
    add_column :users, :waketup_time, :datetime
  end
end
