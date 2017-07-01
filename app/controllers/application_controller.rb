class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :logged_in?, :current_user

  def logged_in?
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_user
    logged_in?
  end

  def send_home
    if logged_in?
      redirect_to root_path
      flash[:danger] = "Already signed in!"
    end
  end
end
