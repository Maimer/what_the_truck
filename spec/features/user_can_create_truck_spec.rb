require 'rails_helper'

feature 'user adds a new truck', %Q{
  As a food truck aficionado
  I want to be able to add a food truck to be reviewed
} do

  scenario 'user adds a new food truck' do
    truck_attrs = {
      name: 'Chicken & Rice Guys',
      description: 'Chicken and Rice by the pound'
    }

    truck = FoodTruck.new(truck_attrs)

    visit new_food_truck_path

    fill_in 'Name', with: truck.name
    fill_in 'Description', with: truck.description
    click_on 'Submit'

    expect(page).to have_content truck.name
    expect(page).to have_content truck.description
  end

  scenario 'user enters blank information for food truck' do
    truck_attrs = {
      name: 'Chicken & Rice Guys',
      description: 'Chicken and Rice by the pound'
    }

    truck = FoodTruck.new(truck_attrs)

    visit new_food_truck_path

    fill_in 'Description', with: truck.description
    click_on 'Submit'

    expect(page).to have_content("Your food truck was not succesfully submitted")
  end

  scenario 'user enters blank information for food truck' do
    truck_attrs = {
      name: 'Chicken & Rice Guys',
      description: 'Chicken and Rice by the pound'
    }

    truck = FoodTruck.new(truck_attrs)

    truck.save

    visit new_food_truck_path

    fill_in 'Name', with: truck.name
    fill_in 'Description', with: truck.description
    click_on 'Submit'

    expect(page).to have_content("This food truck already exists")
  end
end
