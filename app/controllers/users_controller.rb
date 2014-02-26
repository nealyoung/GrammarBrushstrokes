class UsersController < ApplicationController
  # Don't force the user to sign in to create an account
  skip_before_filter :require_login, :only => [:new, :create]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.role = 'student'
    
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Thanks for signing up, #{@user.first_name}. Please log in below."
    else
      flash[:error] = @user.errors.full_messages.first
      render "new"
    end
  end
  
  def show
    if @current_user.is_teacher?
      redirect_to root_path, notice: "Not authorized"
    end
    
    @user = User.find(params[:id])
  end
  
  def destroy
    
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.new(user_params)
    redirect_to root_path, notice: "Profile updated!"
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :first_name, :last_name, :password, :password_confirmation)
  end
end
