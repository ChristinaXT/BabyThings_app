class User < ActiveRecord::Base
  has_secure_password
  has_many :things
  def self.username_taken?(new_name)
    #this method should return true if username is taken and false if username available 
    if params.new_name == params.taken 
      true 
    else 
      false #username available
    end
  end  
end

