require 'rails_helper'

feature 'user votes on a review', %Q{
As a food truck aficionado
I want to be able upvote or downvote a review
additionally I want to be able to change my vote
} do

# Acceptance Criteria

# Ability to upvote or downvote any review
# I must only be able to vote once
# I must be able to change my vote unlimited times
# I must be logged in to my account

scenario 'user upvotes a review' do
  user = FactoryGirl.create(:user)

  visit new_user_session_path

  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password

  click_button 'Sign in'

  review = FactoryGirl.create(:review)

  visit food_truck_path(review.food_truck)

  click_link 'Upvote'

  save_and_open_page

  expect(page).to have_link('Downvote')
  expect(page).to_not have_link('Upvote')
  expect(page).to have_content('Upvotes: 1')
end

scenario 'user downvotes a review' do
  user = FactoryGirl.create(:user)

  visit new_user_session_path

  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password

  click_button 'Sign in'

  review = FactoryGirl.create(:review)

  visit food_truck_path(review.food_truck)

  click_link 'Downvote'

  expect(page).to have_link('Upvote')
  expect(page).to_not have_link('Downvote')
  expect(page).to have_content('Downvotes: 1')

end

scenario 'user changes vote' do
  user = FactoryGirl.create(:user)

  visit new_user_session_path

  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password

  click_button 'Sign in'

  review = FactoryGirl.create(:review)

  visit food_truck_path(review.food_truck)

  click_link 'Upvote'

  click_link 'Downvote'

  expect(page).to have_link('Upvote')
  expect(page).to_not have_link('Downvote')
  expect(page).to have_content('Downvotes: 1')
  expect(page).to have_content('Upvotes: 0')
end

end

