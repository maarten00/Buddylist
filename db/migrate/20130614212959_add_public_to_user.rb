class AddPublicToUser < ActiveRecord::Migration
  def up
    add_column :users, :public_profile, :boolean
  end
  def down
    remove_column :users, :public_profile
  end
end
