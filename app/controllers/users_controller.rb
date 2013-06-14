class UsersController < ApplicationController
  before_filter :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :require_login, only: [:show, :index]
  before_filter :require_friends, only: [:show]
  before_filter :set_friendship, only: [:show, :index]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url, notice: "Signed up!"
    else
      render "new"
    end
  end

  def show
    @blogpostings = Blogposting.all.where(user_id: @user.id)
    @filepostings = Fileposting.all.where(user_id: @user.id)
  end

  def index
    @users = User.all
  end

  def edit

  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  private
  def set_requests
    @user.requested_friendships.each do |request|
      request.user = User.find(request.user_id)
    end
  end

  private
  def set_friendship
    @friendship = Friendship.new
  end

  private
  # Using a private method to encapsulate the permissible parameters is just a good pattern
  # since you'll be able to reuse the same permit list between create and update. Also, you
  # can specialize this method with per-user checking of permissible attributes.
  def user_params
    params.required(:user).permit(:username, :password, :email, :avatar, :password_confirmation)
  end
end
