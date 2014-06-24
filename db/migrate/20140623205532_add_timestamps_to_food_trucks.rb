class AddTimestampsToFoodTrucks < ActiveRecord::Migration
  def change
    add_timestamps :food_trucks
  end
end
