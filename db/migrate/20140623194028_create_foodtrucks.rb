class CreateFoodtrucks < ActiveRecord::Migration
  def change
    create_table :food_trucks do |t|
      t.string :name, null: false
      t.text :description, null: false
    end
    add_index :food_trucks, :name, unique: true
  end
end
