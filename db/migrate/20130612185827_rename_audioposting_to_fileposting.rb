class RenameAudiopostingToFileposting < ActiveRecord::Migration
  def up
    rename_column :audiopostings, :audiofile, :file
    rename_table :audiopostings, :filepostings
  end

  def down
    rename_column :filepostings, :file, :audiofile
    rename_table :filepostings, :audiopostings
  end
end
