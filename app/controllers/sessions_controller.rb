class SessionsController < ApplicationController
  skip_before_filter :require_login
  
  def create
    user = User.find_by_email(params[:email])
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
  end
end
