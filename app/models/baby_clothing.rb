class BabyClothing < ActiveRecord::Base
  has_many :baby_clothing 
  belongs_to :user
end