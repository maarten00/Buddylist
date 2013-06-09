class Audioposting < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy
  include ActiveModel::ForbiddenAttributesProtection
  acts_as_taggable
  mount_uploader :audiofile, AudioUploader

  validates_presence_of :user_id, :audiofile

  default_scope :order => 'audiopostings.created_at desc'
end
