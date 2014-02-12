class SessionsController < ApplicationController
  skip_before_filter :require_login
  
  def create
    user = User.find_by_username(params[:username])
        
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to participles_path
    else      
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
