require 'rails_helper'

feature 'user receives an email after they leave a review', %Q{
As a food truck aficionado
I want to receive an email after I leave a new review on a food truck
} do


  scenario 'user creates a new review' do
    ActionMailer::Base.deliveries = []
    # prev_count = ReviewMailer.count

    user = FactoryGirl.create(:user)
    food_truck = FactoryGirl.create(:food_truck)

    visit new_food_truck_review_path(food_truck)

    # fill_in 'Rating', with: 4
    fill_in 'Body', with: 'This is a review body'
    click_button 'Submit'

    expect(page).to have_content(user.first_name)
    expect(ReviewMailer.count).to eq(prev_count + 1)

    expect(ActionMailer::Base.deliveries.size).to eql(1)

    last_email = ActionMailer::Base.deliveries.last
    expect(last_email).to have_subject("Your review on #{food_truck.name}")
    expect(last_email).to deliver_to(user.email)
  end

end
