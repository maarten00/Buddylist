class CreateFilepostings < ActiveRecord::Migration
  def change
    create_table :filepostings do |t|
      t.integer :user_id
      t.string :audiofile

      t.timestamps
    end
  end
end
