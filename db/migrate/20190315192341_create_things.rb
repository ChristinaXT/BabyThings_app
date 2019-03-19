class CreateThings < ActiveRecord::Migration[5.2]
  def change
    create_table :things do |t|
     t.string :content
     t.integer :user_id
   end
 end
end
