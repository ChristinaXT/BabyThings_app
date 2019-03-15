class CreateThings < ActiveRecord::Migration[5.2]
  def change
    create_table :things do |i|
     i.string :name
     i.integer :user_id
   end
 end
end
