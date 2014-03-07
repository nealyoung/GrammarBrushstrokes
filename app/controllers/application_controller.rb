class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :require_login, :except => [:users]
  
  private
  
  def require_login
    unless current_user
      redirect_to log_in_path
    end
  end
  
  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]

#    if session[:user_id]
#      @current_user ||= User.find(session[:user_id])
#    end
  end
  
  helper_method :current_user
end
