class AddPhotoToFoodTruck < ActiveRecord::Migration
  def change
    add_column :food_trucks, :truck_photo, :string
  end
end
