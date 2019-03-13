class CreateClothingItems < ActiveRecord::Migration
  def change
    create_table :clothingitems do |i|
     i.string :content
     i.integer :user_id
   end
 end
end 
