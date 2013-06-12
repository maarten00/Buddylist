class AddTitleToFileposting < ActiveRecord::Migration
  def up
    add_column :filepostings, :title, :string
  end

  def down
    remove_column :filepostings, :title
  end
end
