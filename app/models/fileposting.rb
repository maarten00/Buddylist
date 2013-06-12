class Fileposting < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy
  include ActiveModel::ForbiddenAttributesProtection
  acts_as_taggable
  mount_uploader :file, AudioUploader

  validates_presence_of :user_id, :file, :title

  default_scope :order => 'filepostings.created_at desc'
end
