class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :day_of_week, null: false
      t.string :time_of_day, null: false
      t.string :address
      t.string :coordinates
      t.integer :food_truck_id, null: false
      t.timestamps
    end
  end
end
