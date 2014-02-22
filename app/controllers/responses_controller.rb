class ResponsesController < ApplicationController
  def new
    # Before allowing the student to create a new response, we check if they have previously opened but incomplete responses
    incomplete_responses = Response.incomplete_responses_for_user @current_user
    if incomplete_responses.any?
      flash[:alert] = 'You need to complete a previously started response'
      @response = incomplete_responses.take
      
      puts @response
    else
      @response = Response.new
      @response.user = @current_user
      questions_in_category = Question.where(category_id: params[:category_id])
      @response.question = questions_in_category.first(offset: rand(questions_in_category.count))
    
      @response.save
    end    
  end

  def update
    @response = Response.find(params[:id])
    
    if @response.update_attributes(response_params)
      redirect_to root_path, notice: 'Your response has been saved.'
    else
      render action: 'edit'
    end
  end
  
  def show
    @response = Response.find(params[:id])
  end
  
  def review
    # Find responses awaiting review that do not belong to the current user and have not been reviewed yet
    @response = Response.where('user_id != ? AND reviewer_id = ?', @current_user.id, nil).first
    
    if @response.nil?
      redirect_to root_path, notice: 'There are no responses to review at this time'
    else
      # Assign the current user as the reviewer
      @response.reviewer_id = @current_user.id
    end
  end
  
  private
  
  def response_params
    params.require(:response).permit(:sentence1, :sentence2, :sentence3, :revised_sentence1, :revised_sentence2, :revised_sentence3, :best_sentence, :worst_sentence, :best_sentence_feedback, :worst_sentence_feedback)
  end
end
