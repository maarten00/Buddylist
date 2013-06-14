class User < ActiveRecord::Base
  has_many :blogpostings
  has_many :comments

  #Friendships
  has_many :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :direct_friends, :through => :friendships, :conditions => "approved = 't'", :source => :friend
  has_many :inverse_friends, :through => :inverse_friendships, :conditions => "approved = 't'", :source => :user
  #Friendship Requests
  has_many :pending_friends, :through => :friendships, :conditions => "approved = 'f'", :foreign_key => :user_id, :source => :friend
  has_many :requested_friendships, :class_name => "Friendship", :foreign_key => "friend_id", :conditions => "approved = 'f'"

  mount_uploader :avatar, ImageUploader

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

  def requested_friends
    requested_friends =  Array.new
    requested_friendships.each do |request|
      requested_friends.push(User.find(request.user_id))
    end
    requested_friends
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
