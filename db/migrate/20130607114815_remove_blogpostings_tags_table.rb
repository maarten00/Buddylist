class RemoveBlogpostingsTagsTable < ActiveRecord::Migration
  def up
    drop_table :blogpostings_tags
  end

  def down
    create_table :blogpostings_tags do |t|
      t.integer :tag_id
      t.integer :blogposting_id
      t.timestamps
    end
  end
end
