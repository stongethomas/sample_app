class AddItem2NameToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :item2_name, :string
  end

  def self.down
    remove_column :users, :item2_name
  end
end
