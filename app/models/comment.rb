class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :blogposting
  belongs_to :audioposting

  validates :user_id, :presence => true
  validate :blogposting_xor_audioposting_xor_videoposting
  validates :content, :presence => true, :length => {:maximum => 50000}

  default_scope :order => 'comments.created_at asc'

  private

  def blogposting_xor_audioposting_xor_videoposting
    if !(blogposting.blank? ^ audioposting.blank?)
      errors.add("Comment must be placed on a blog, audio or videoposting.")
    end
  end

end
