class AddCommentToProgres < ActiveRecord::Migration
  def self.up
    add_column :progres, :comment, :string
  end

  def self.down
    remove_column :progres, :comment
  end
end
