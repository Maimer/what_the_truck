require 'rails_helper'

feature 'user adds a review', %Q{
  As a food truck aficionado
  I want to be able to add a food truck to be reviewed
} do

  scenario 'user adds a new truck review' do
    review = FactoryGirl.build(:review)

    visit new_user_session_path

    fill_in 'Email', with: review.user.email
    fill_in 'Password', with: review.user.password
    click_on 'Sign in'

    visit food_truck_path(review.food_truck)

    click_on 'Create a New Review!'

    fill_in 'Rating', with: review.rating
    fill_in 'Body', with: review.body
    click_on 'Create Review'

    expect(page).to have_content review.food_truck.name
    expect(page).to have_content review.body
  end

  scenario 'user fails to add truck review' do
    truck = FactoryGirl.create(:food_truck)

    visit new_user_session_path

    fill_in 'Email', with: truck.user.email
    fill_in 'Password', with: truck.user.password
    click_on 'Sign in'

    visit food_truck_path(truck)

    click_on 'Create a New Review!'

    fill_in 'Rating', with: ''
    fill_in 'Body', with: ''
    click_on 'Create Review'

    expect(page).to have_content("Your review was not succesfully submitted")
  end
end
