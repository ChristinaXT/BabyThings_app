class User < ActiveRecord::Base
  has_secure_password
  has_many :baby_clothing
  has_many :baby_accessories
end