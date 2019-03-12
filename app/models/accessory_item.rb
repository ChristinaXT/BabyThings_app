class Accessory_Item < ActiveRecord::Base
  has_many :accessory_items
  belongs_to :user
end
