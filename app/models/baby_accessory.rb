class BabyAccessory < ActiveRecord::Base 
  has_many :baby_accessories
  belongs_to :user
end 