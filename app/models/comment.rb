class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :blogposting
  belongs_to :fileposting

  validates :user_id, :presence => true
  validate :blogposting_xor_fileposting
  validates :content, :presence => true, :length => {:maximum => 50000}

  default_scope :order => 'comments.created_at asc'

  private
  def blogposting_xor_fileposting
    if !(blogposting.blank? ^ fileposting.blank?)
      errors.add("Comment must be placed on a blog, audio or videoposting.")
    end
  end

end
