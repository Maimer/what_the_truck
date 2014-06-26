class AddAverageRatingToFoodTrucks < ActiveRecord::Migration
  def change
    add_column :food_trucks, :average_rating, :float, default: 0.0
  end
end
