class FriendshipsController < ApplicationController
  before_filter :require_login
  before_filter :set_requests, only: [:index]

  def accept
    @friendship = Friendship.find(params[:request_id])
    @friendship.approved = "true"
    if @friendship.save
      redirect_to User.find(params[:user_id]), notice: "You are now friends!"
    end
  end

  def new
    @friendship = Friendship.new(user_id: current_user.id, friend_id: params[:friend_id], approved: 'false')
    if @friendship.save
      redirect_to users_url, :notice => "Friendship requested!"
    else
      redirect_to users_url, :notice => "Something went wrong.."
    end
  end

  private
  def set_requests
    @requests = current_user.requested_friendships
    @requests.each do |request|
      request.user = User.find(request.user_id)
    end
  end

end
