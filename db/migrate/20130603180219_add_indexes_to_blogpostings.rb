class AddIndexesToBlogpostings < ActiveRecord::Migration
  def change
    add_index :tags, :id
    add_index :blogpostings_tags, :tag_id
    add_index :blogpostings_tags, :blogposting_id
    add_index :blogpostings, :id
  end
end
