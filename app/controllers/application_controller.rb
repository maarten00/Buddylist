class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  def merge_and_sort_postings
    @postings = @filepostings | @blogpostings
    @postings = @postings.sort { |postingA, postingB| postingA.created_at <=> postingB.created_at }.reverse
  end

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    unless current_user
      redirect_to new_session_url, notice: 'You need to log in to view this page'
    end
  end

  def require_friends
    user = User.find(params[:id])
    unless current_user == user || user.public_profile == true || current_user.friends.include?(user) || current_user.requested_friends.include?(user)
      redirect_to users_path, notice: 'You need to be friends with this user to view this page.'
    end
  end

  def set_user(posting)
    @user = User.find(posting.user_id)
  end

  def get_comments(posting)
    @comments = posting.comments.all
  end

end
