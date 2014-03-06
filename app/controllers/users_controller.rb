class UsersController < ApplicationController
  # Don't force the user to sign in to create an account
  skip_before_filter :require_login, :only => [:new, :create]

  def index
    if !@current_user.is_teacher?
      redirect_to root_path, notice: "Not authorized"
    end
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.role = 'student'

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Thanks for signing up, #{@user.first_name}."
    else
      flash[:error] = @user.errors.full_messages.first
      render "new"
    end
  end

  def show
    @categories = Category.all
    @user = User.find(params[:id])
    if !@current_user.is_teacher? && @user != @current_user
      redirect_to @current_user
    end
  end

  def destroy

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to root_path, notice: "Profile updated successfully!"
    else
      flash[:error] = @user.errors.full_messages.first
      render 'edit'
    end
  end
  
  def generate_report
    report = Prawn::Document.new
    
    User.all.each do |user|
      if user.role == 'student'
        report.text user.full_name
      end
    end
    
    send_data report.render, type: "application/pdf", disposition: 'inline'
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :first_name, :last_name, :password, :password_confirmation)
  end
end
