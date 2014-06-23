class CreateFoodtrucks < ActiveRecord::Migration
  def change
    create_table :foodtrucks do |t|
      t.string :name, null: false
      t.text :description, null: false
    end
    add_index :foodtrucks, :name, unique: true
  end
end
