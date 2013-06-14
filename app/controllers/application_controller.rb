class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user


  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    unless current_user
      redirect_to new_session_url, :notice => 'You need to log in to view this page'
    end
  end

  def require_friends
    if ! current_user.friends.include?(User.find(params[:id]))
      unless current_user == User.find(params[:id])
        redirect_to users_path, notice: 'You need to be friends with this user to view this page.'
      end
    end
  end

end
