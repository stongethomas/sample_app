class AddItem1NameToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :item1_name, :string
  end

  def self.down
    remove_column :users, :item1_name
  end
end
