require 'rails_helper'

feature 'admin views index page', %Q{
As a food truck admin
I want to be able to view all food trucks and delete any that violate terms
} do

  scenario 'admin views all trucks' do
    user = FactoryGirl.create(:user, admin: true)
    food_truck = FactoryGirl.create(:food_truck)

    visit root_path

    first(:link, 'Sign In').click
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'

    visit admin_food_trucks_path

    expect(page).to have_content food_truck.name
  end

  scenario 'admin deletes truck' do
    user = FactoryGirl.create(:user, admin: true)
    food_truck = FactoryGirl.create(:food_truck)

    visit root_path

    first(:link, 'Sign In').click
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'

    visit admin_food_trucks_path

    expect(page).to have_content food_truck.name

    page.find_link(admin_food_truck_path(food_truck)).click #test can't find the link

    expect(page).to_not have_content food_truck.name
  end

end
