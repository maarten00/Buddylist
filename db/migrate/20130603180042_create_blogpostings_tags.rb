class CreateBlogpostingsTags < ActiveRecord::Migration
  def change
    create_table :blogpostings_tags do |t|
        t.integer :tag_id
        t.integer :blogposting_id
      t.timestamps
    end
  end
end
