class AddSitelinkIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :sitelink_id, :int
  end

  def self.down
    remove_column :users, :sitelink_id
  end
end
