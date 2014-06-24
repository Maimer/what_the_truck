require 'rails_helper'

feature 'user adds a review', %Q{
  As a food truck aficionado
  I want to be able to add a food truck to be reviewed
} do

  scenario 'user adds a new truck review' do
    review = FactoryGirl.create(:review)
    visit food_truck_path(review.food_truck)

    fill_in 'Rating', with: review.rating
    fill_in 'Body', with: review.body
    click_on 'Submit'

    expect(page).to have_content review.food_truck.name
    expect(page).to have_content review.rating
    expect(page).to have_content review.body
  end

  scenario 'user fails to add truck review' do
    truck = FactoryGirl.create(:food_truck)

    visit food_truck_path(truck)

    fill_in 'Rating', with: ''
    fill_in 'Body', with: ''
    click_on 'Submit'

    expect(page).to have_content("Your review was not succesfully submitted")
  end
end
