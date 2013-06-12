class RenameAudiopostingIdToFilepostingId < ActiveRecord::Migration

  def up
    rename_column :comments, :audioposting_id, :fileposting_id
  end

  def down
    rename_column :comments, :fileposting_id, :audioposting_id
  end
end