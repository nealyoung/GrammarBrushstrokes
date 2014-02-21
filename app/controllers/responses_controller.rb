class ResponsesController < ApplicationController
  def new
    @response = Response.new
    questions_in_category = Question.where(category_id: params[:category_id])
    @response.question = questions_in_category.first(offset: rand(questions_in_category.count))
  end

  def create
    @response = Response.create(response_params)
    @reponse.user_id = @current_user.id
    
    if @response.save
      redirect_to root_path, notice: 'Your response has been saved.'
    else
      format.html { render action: "new" }
      format.json { render json: @article.errors, status: :unprocessable_entity }
    end
  end
  
  def show
    @response = Response.find(params[:id])
  end
  
  def review
    # Find responses awaiting review that do belong to the current user
    @response = Response.where('user_id != ?', @current_user.id).first
    
    if @response.nil?
      redirect_to root_path, notice: 'No responses to review'
      return
    end
    
    # Assign the current user as the reviewer 
    @response.reviewer_id = @current_user.id
  end
  
  private
  
  def response_params
    params.require(:response).permit(:sentence1, :sentence2, :sentence3, :revised_sentence1, :revised_sentence2, :revised_sentence3, :best_sentence, :worst_sentence, :best_sentence_feedback, :worst_sentence_feedback)
  end
end
