class CreatePartiesScopes < ActiveRecord::Migration
  def self.up
    create_table :parties_scopes do |t|
      t.integer :party_id
      t.integer :scope_id

      t.timestamps
    end
  end

  def self.down
    drop_table :parties_scopes
  end
end
