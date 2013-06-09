class CreateAudiopostings < ActiveRecord::Migration
  def change
    create_table :audiopostings do |t|
      t.integer :user_id
      t.string :audiofile

      t.timestamps
    end
  end
end
