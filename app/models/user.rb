class User < ActiveRecord::Base
  has_secure_password
  has_many :things
  
 def self.username_check(username)
    self.all.detect do |user|
      user.username == username
    end
  end

end

