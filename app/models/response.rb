class Response < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  
  scope :completed, -> { where('revised_sentence1 IS NOT NULL AND revised_sentence2 IS NOT NULL AND revised_sentence3 IS NOT NULL') }
  
  def self.incomplete_responses_for_user(user)
    user.responses.where(sentence1: nil, sentence2: nil, sentence3: nil)
  end
  
  def self.incomplete_reviews_for_user(user)
    Response.where(reviewer_id: user.id, best_sentence_feedback: nil, worst_sentence_feedback: nil)
  end
  
  def self.response_for_peer_review_by_user(user)
    Response.where('user_id != ? AND reviewer_id IS NULL AND sentence1 IS NOT NULL AND sentence2 IS NOT NULL AND sentence3 IS NOT NULL', user.id).first
  end
  
  def self.response_for_revision_by_user(user)
    Response.where('user_id = ? AND best_sentence_feedback IS NOT NULL AND worst_sentence_feedback IS NOT NULL AND revised_sentence1 IS NULL AND revised_sentence2 IS NULL AND revised_sentence3 IS NULL', user.id).first
  end
end
