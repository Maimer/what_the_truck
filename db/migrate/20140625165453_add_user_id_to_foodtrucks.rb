class AddUserIdToFoodtrucks < ActiveRecord::Migration
  def change
    add_column :food_trucks, :user_id, :integer, null: false
  end
end
