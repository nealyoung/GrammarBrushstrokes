class ResponsesController < ApplicationController
  def new
    @response = Response.new
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
