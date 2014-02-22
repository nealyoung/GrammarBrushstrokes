class Response < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  
  def self.incomplete_responses_for_user(user)
    user.responses.where(sentence1: nil, sentence2: nil, sentence3: nil)
  end
end
