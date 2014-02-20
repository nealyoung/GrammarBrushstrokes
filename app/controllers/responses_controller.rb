class ResponsesController < ApplicationController
  def new
    @response = Response.new
    questions_in_category = Question.where(category_id: params[:category_id])
    @response.question = questions_in_category.first(offset: rand(questions_in_category.count))
  end

  def create
    
  end
  
  def show
    @response = Response.find(params[:id])
  end
  
  private
  
  def response_params
    params.require(:response).permit(:title, :information, :photo_url, :user_id, :category_id)
  end
end
