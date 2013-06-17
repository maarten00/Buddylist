class CreatePersonalPostings < ActiveRecord::Migration
  def change
    create_table :personal_postings do |t|
      t.integer :user_id
      t.string :content
      t.integer :receiver_id

      t.timestamps
    end
  end
end
