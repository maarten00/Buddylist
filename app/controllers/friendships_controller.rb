class FriendshipsController < ApplicationController
  before_action :require_login
  before_action :set_requests, only: [:index]

  def update
    @friendship = Friendship.find(friendship_params[:id])
    @friendship.approved = "true"
    if @friendship.save
      redirect_to User.find(@friendship.user_id), notice: "You are now friends!"
    end
  end

  def create
    @friendship = Friendship.new(user_id: current_user.id, friend_id: friendship_params[:friend_id], approved: 'false')
    if @friendship.save
      redirect_to users_url, notice: "Friendship requested!"
    else
      redirect_to users_url, notice: "Something went wrong.."
    end
  end

  private
  def set_requests
    @requests = current_user.requested_friendships
    @requests.each do |request|
      request.user = User.find(request.user_id)
    end
  end

  private
  def friendship_params
    params.required(:friendship).permit(:id, :user_id, :friend_id)
  end
end
