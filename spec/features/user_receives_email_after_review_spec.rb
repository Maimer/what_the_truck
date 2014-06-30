require 'rails_helper'

feature 'user receives an email after they leave a review', %Q{
As a food truck aficionado
I want to receive an email after I leave a new review on a food truck
} do


  scenario 'user creates a new review' do
    ActionMailer::Base.deliveries = []

    user = FactoryGirl.create(:user)
    review = FactoryGirl.create(:review)

    visit root_path

    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'

    visit food_truck_path(review.food_truck)

    click_link 'Create a New Review!'


    fill_in 'Rating', with: 4
    fill_in 'Body', with: 'This is a review body'
    click_button 'Submit'

    expect(page).to have_content(user.first_name)

    expect(ActionMailer::Base.deliveries.size).to eql(1)

    last_email = ActionMailer::Base.deliveries.last
    expect(last_email).to have_subject("Your review on #{review.food_truck.name}")
    expect(last_email).to deliver_to(user.email)
  end

end
