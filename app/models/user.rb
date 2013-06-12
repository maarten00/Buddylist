class User < ActiveRecord::Base
  has_many :blogpostings
  has_many :comments

  has_many :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :direct_friends, :through => :friendships, :conditions => "approved = 'true'", :source => :friend
  has_many :inverse_friends, :through => :inverse_friendships, :conditions => "approved = 'true'", :source => :user

  has_many :pending_friends, :through => :friendships, :conditions => "approved = 'false'", :foreign_key => "user_id", :source => :user
  has_many :requested_friendships, :class_name => "Friendship", :foreign_key => "friend_id", :conditions => "approved = 'false'"

  mount_uploader :avatar, ImageUploader
  attr_accessor :password
  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :username
  validates_presence_of :password, :on => :create


  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def friends
    direct_friends | inverse_friends
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
