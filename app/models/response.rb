class Response < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  
  def self.incomplete_responses_for_user(user)
    user.responses.where(sentence1: nil, sentence2: nil, sentence3: nil)
  end
  
  def self.incomplete_reviews_for_user(user)
    Response.where(reviewer_id: user.id, best_sentence_feedback: nil, worst_sentence_feedback: nil)
  end
end
