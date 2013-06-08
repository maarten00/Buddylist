class Blogposting < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy
  include ActiveModel::ForbiddenAttributesProtection
  acts_as_taggable

  validates_presence_of :user_id, :content

  default_scope :order => 'blogpostings.created_at desc'
end
