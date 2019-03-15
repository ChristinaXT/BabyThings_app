class CreateThings < ActiveRecord::Migration
  def change
    create_table :things do |i|
     i.string :content
     i.integer :user_id
   end
 end
end
