class BabyClothes < ActiveRecord::Base
  has_many :baby_clothes
  belongs_to :user
end