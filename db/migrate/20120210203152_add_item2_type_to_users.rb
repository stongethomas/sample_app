class AddItem2TypeToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :item2_type, :string
  end

  def self.down
    remove_column :users, :item2_type
  end
end
