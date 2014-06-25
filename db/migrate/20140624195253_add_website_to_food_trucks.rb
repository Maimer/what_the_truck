class AddWebsiteToFoodTrucks < ActiveRecord::Migration
  def change
    add_column :food_trucks, :website, :string
  end
end
