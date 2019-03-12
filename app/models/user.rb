class User < ActiveRecord::Base
  has_secure_password
  has_many :clothing_items
  has_many :accessory_items
end 
