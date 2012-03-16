class AddItem1TypeToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :item1_type, :string
  end

  def self.down
    remove_column :users, :item1_type
  end
end
