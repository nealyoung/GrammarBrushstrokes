class ResponsesController < ApplicationController
  def new
    # Before allowing the student to create a new response, we check if they have previously opened but incomplete responses
    incomplete_responses = Response.incomplete_responses_for_user @current_user
    if incomplete_responses.any?
      flash[:alert] = 'You need to complete a previously started response'
      @response = incomplete_responses.first
      
      puts @response
    else
      @response = Response.new
      @response.user = @current_user
      #questions_in_category = Question.where(category_id: params[:category_id])
      questions_in_category = Question.all
      @response.question = questions_in_category.first(offset: rand(questions_in_category.count))
    
      @response.save
    end    
  end

  def update
    @response = Response.find(params[:id])
    
    update_params = response_params
    
    # The parameters for best and worst sentence come as strings as displayed in the dropdown, we need to convert them to numbers to store in the database
    case update_params[:best_sentence]
    when 'Sentence A'
      update_params[:best_sentence] = 1
    when 'Sentence B'
      update_params[:best_sentence] = 2
    when 'Sentence C'
      update_params[:best_sentence] = 3
    end
    
    case update_params[:worst_sentence]
    when 'Sentence A'
      update_params[:worst_sentence] = 1
    when 'Sentence B'
      update_params[:worst_sentence] = 2
    when 'Sentence C'
      update_params[:worst_sentence] = 3
    end

    if @response.update_attributes(update_params)
      if @response.reviewer_id == @current_user.id
        redirect_to root_path, notice: 'Your review has been sent to the author.'
      else
        redirect_to root_path, notice: 'Your response has been sent to a peer for review.'
      end
    else
      flash[:alert] = 'There was an error saving your response'
      render action: 'edit'
    end
  end
  
  def show
    @response = Response.find(params[:id])
  end
  
  def review
    incomplete_reviews = Response.incomplete_reviews_for_user @current_user
    
    if incomplete_reviews.any?
      flash[:alert] = 'You need to complete a previously started review'
      @response = incomplete_reviews.first
    else
      # Find responses awaiting review that do not belong to the current user and have not been reviewed yet
      @response = Response.response_for_peer_review_by_user(@current_user)
    
      if @response.nil?
        redirect_to root_path, notice: 'You have no responses to review at this time'
      else
        # Assign the current user as the reviewer
        @response.reviewer_id = @current_user.id
        @response.save
      end
    end
  end
  
  def revise
    @response = Response.response_for_revision_by_user(@current_user)
    
    if @response.nil?
      redirect_to root_path, notice: 'You have no responses to revise'
    end
  end
  
  private
  
  def response_params
    params.require(:response).permit(:sentence1, :sentence2, :sentence3, :revised_sentence1, :revised_sentence2, :revised_sentence3, :best_sentence, :worst_sentence, :best_sentence_feedback, :worst_sentence_feedback)
  end
end
