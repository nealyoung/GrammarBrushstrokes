class CoursesController < ApplicationController
  skip_before_filter :require_course_membership, :only => [:join]
  
  def new
    @course = Course.new
  end
  
  def update
    @course = Course.new(course_params)
    
    if @course.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Thanks for signing up, #{@user.first_name}."
    else
      flash[:error] = @user.errors.full_messages.first
      render "new"
    end
  end
  
  def join
    @courses_without_teachers = Course.where(teacher_id: nil)
  end
  
  def teach
    if @current_user.role == 'student'
      redirect_to root_path, notice: "Unauthorized"
    end
    
    course = Course.find(params[:id])
    course.teacher = @current_user
    if course.save
      redirect_to root_path, notice: "You are now teaching #{course.title}"
    else
      redirect_to root_path, alert: "Error adding course"
    end
  end
  
  private
  
  def course_params
    params.require(:course).permit(:title)
  end
end
