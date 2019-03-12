class BabyClothing < ActiveRecord::Base
  has_many :baby_clothings
  belongs_to :user
end