class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :password
  
  validates :email, :presence => true, :uniqueness => true
  validates :email, :format => {:with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/}

  validates :password, :presence => true, :confirmation => true
 
end
