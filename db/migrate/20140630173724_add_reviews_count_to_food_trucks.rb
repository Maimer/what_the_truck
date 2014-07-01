class AddReviewsCountToFoodTrucks < ActiveRecord::Migration
  def change
    add_column :food_trucks, :reviews_count, :integer, default: 0
  end
end
