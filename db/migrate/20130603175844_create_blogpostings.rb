class CreateBlogpostings < ActiveRecord::Migration
  def change
    create_table :blogpostings do |t|
      t.integer :user_id
      t.string :content

      t.timestamps
    end
  end
end
