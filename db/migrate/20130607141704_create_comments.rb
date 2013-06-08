class CreateComments < ActiveRecord::Migration
  def up
    create_table :comments do |t|
      t.integer :user_id
      t.integer :blogposting_id
      t.string :content , :null => false

      t.timestamps
    end
    add_index :comments, [:user_id, :blogposting_id]
  end

  def down
    drop_table :comments
  end
end
