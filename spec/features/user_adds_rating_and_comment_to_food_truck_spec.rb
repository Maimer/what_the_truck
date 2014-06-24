require 'rails_helper'

feature 'user adds a review', %Q{
  As a food truck aficionado
  I want to be able to add a food truck to be reviewed
} do

  scenario 'user adds a new truck review' do

    truck = FactoryGirl.create(:food_truck)

    review = FactoryGirl.create(:review)

    visit food_truck_path(truck)

    fill_in 'Rating', with: review.rating
    fill_in 'Body', with: review.body
    click_on 'Submit'

    expect(page).to have_content truck.name
    expect(page).to have_content review.rating
    expect(page).to have_content review.body
  end
end
