class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :blogposting

  validates :user_id, :presence => true
  validates :blogposting_id, :presence => true
  validates :content, :presence => true, :length => { :maximum => 50000 }

  default_scope :order => 'comments.created_at asc'

end
