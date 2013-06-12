class AddTypeToFilePosting < ActiveRecord::Migration
  def change
    add_column :filepostings, :type, :string
  end
end
