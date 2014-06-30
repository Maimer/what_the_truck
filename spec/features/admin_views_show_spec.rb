require 'rails_helper'

feature 'admin views index page', %Q{
As a food truck admin
I want to be able to view a food truck page and delete reviews if I want to
} do

  scenario 'admin views a food trucks' do
    user = FactoryGirl.create(:user, admin: true)
    food_truck = FactoryGirl.create(:food_truck)

    visit root_path

    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'

    visit admin_food_truck_path(food_truck)

    expect(page).to have_content food_truck.name
  end

  scenario 'admin deletes review' do
    user = FactoryGirl.create(:user, admin: true)
    review = FactoryGirl.create(:review)

    visit root_path

    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'

    visit admin_food_truck_path(review.food_truck)

    expect(page).to have_content review.food_truck.name
    expect(page).to have_content review.body

    page.find_link(admin_review_path(review.id)).click

    expect(page).to_not have_content review.body
  end

end
