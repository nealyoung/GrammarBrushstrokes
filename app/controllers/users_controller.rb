require "open-uri"

class UsersController < ApplicationController
  # Don't force the user to sign in to create an account
  skip_before_filter :require_login, :only => [:new, :create]
  skip_before_filter :require_course_membership, :only => [:update]

  def index
    if !@current_user.is_teacher?
      redirect_to root_path, notice: "Not authorized"
    end
    
    @users = @current_user.taught_course.students
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
    if @current_user.is_teacher?
      report = Prawn::Document.new
      
      report.text @current_user.taught_course.title, style: :bold, size: 30, align: :center
      
      report.text DateTime.now.strftime("Generated on %m/%d/%Y at %I:%M%p"), style: :italic, size: 14, align: :center
      
      @current_user.taught_course.students.each do |student|
        if student.responses.completed.any?
          report.text student.full_name, style: :bold
        
          student.responses.completed.each do |response|
            report.image open(response.question.image_url), width: 200
            report.move_down 5
            report.text "Sentence 1: " + response.sentence1
            report.text "Revised Sentence 1: " + response.revised_sentence1

            report.text "Sentence 2: " + response.sentence1
            report.text "Revised Sentence 2: " + response.revised_sentence1
            
            report.text "Sentence 3: " + response.sentence2
            report.text "Revised Sentence 3: " + response.revised_sentence3
          end
        end
      end
      
      send_data report.render, type: "application/pdf", disposition: 'inline'
    else
      redirect_to root_path, alert: 'Not authorized'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :first_name, :last_name, :course_id, :password, :password_confirmation)
  end
end
