class User < ActiveRecord::Base
  has_secure_password
  has_many :baby_clothes
  has_many :baby_accessories
end