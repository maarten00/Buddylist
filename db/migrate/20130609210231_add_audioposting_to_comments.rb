class AddAudiopostingToComments < ActiveRecord::Migration
  def up
    add_column :comments, :audioposting_id, :string
  end

  def down
    remove_column :comments, :audioposting_id
  end
end
