class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :rating, null: false
      t.text :body
      t.integer :food_truck_id
      t.timestamps
    end
  end
end
