module HasFriends
  extend ActiveSupport::Concern

  included do
    #Friendships
    has_many :friendships
    has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
    has_many :direct_friends, :through => :friendships, :conditions => "approved = 't'", :source => :friend
    has_many :inverse_friends, :through => :inverse_friendships, :conditions => "approved = 't'", :source => :user
    #Friendship Requests
    has_many :pending_friends, :through => :friendships, :conditions => "approved = 'f'", :foreign_key => :user_id, :source => :friend
    has_many :requested_friendships, :class_name => "Friendship", :foreign_key => "friend_id", :conditions => "approved = 'f'"

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
  end

end