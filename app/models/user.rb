class User < ActiveRecord::Base
  has_secure_password
  has_many :things
  validates :username, :presence => true, 
                       :uniqueness => true
  validates :email,    :presence => true,
                       :uniqueness => true
  validates :password, :presence => true
  #def self.username_taken?(new_name)
    #this method should return true if username is taken and false if username available 
    #if new_name.exists? 
      #true 
   # else 
      #false #username available
   # end
  #end  
 def self.username_check(username)
    self.all.detect do |user|
      user.username == username
    end
  end

end

