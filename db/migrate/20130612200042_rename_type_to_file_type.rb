class RenameTypeToFileType < ActiveRecord::Migration
  def change
    rename_column :filepostings, :type, :filetype
  end
end
