class User < ActiveRecord::Base
  has_secure_password
  has_many :baby_clothings
  has_many :baby_accessories
end