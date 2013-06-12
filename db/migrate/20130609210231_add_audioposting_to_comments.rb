class AddFilepostingToComments < ActiveRecord::Migration
  def up
    add_column :comments, :fileposting_id, :string
  end

  def down
    remove_column :comments, :fileposting_id
  end
end
