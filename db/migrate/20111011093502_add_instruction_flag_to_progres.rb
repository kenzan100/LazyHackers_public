class AddInstructionFlagToProgres < ActiveRecord::Migration
  def self.up
    add_column :progres, :instruction_flag, :boolean
  end

  def self.down
    remove_column :progres, :instruction_flag
  end
end
