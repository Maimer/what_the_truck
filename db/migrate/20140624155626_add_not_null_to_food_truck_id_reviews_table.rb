class AddNotNullToFoodTruckIdReviewsTable < ActiveRecord::Migration
  def change
    change_column :reviews, :food_truck_id, :integer, null: false
  end
end
