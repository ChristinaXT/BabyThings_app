class CreateClothingItems < ActiveRecord::Migration
  def change
    create_table :clothing_items do |i|
     i.string :content
     i.integer :user_id
   end
 end
end
