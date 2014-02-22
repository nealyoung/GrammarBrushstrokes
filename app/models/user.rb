class User < ActiveRecord::Base
  has_secure_password
  
  has_many :responses
  
  EMAIL_REGEX = /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i
  validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
  
  def is_teacher?
    return role == 'teacher'
  end
  
  def full_name
    "#{first_name} #{last_name}"
  end
end
