class User < ActiveRecord::Base
  has_secure_password
  has_many :things
  def self.username_taken?(new_name)
    #this method should return true if username is taken and false if username available 
    if new_name.exists? == username_taken 
      true 
    else 
      false #username available
    end
  end  
end

