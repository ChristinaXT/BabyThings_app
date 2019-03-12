class Clothing_Item < ActiveRecord::Base
  has_many :clothing_items
  belongs_to :user
end
