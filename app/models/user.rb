class User < ActiveRecord::Base
  acts_as_authentic
  attr_accessible :login, :email, :password, :password_confirmation, :avatar
  has_many :posts

# models/product.rb
has_attached_file :avatar, :styles => { :small => "150x150>" }
                  
                  
end
