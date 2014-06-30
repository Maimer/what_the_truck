require 'rails_helper'

feature 'user signs up', %Q{
As a food truck aficionado
I want to be able to create an account so that I can log in to the site
} do

# Acceptance Criteria

# I must provide my username/email and password
# I can optionally provide my first name, last name, and avatar
# I am presented with a success message if I sign in successfully
# I'm presented with errors if I provide invalid credentials

  scenario 'user inputs valid and required information and avatar' do
    visit root_path
    click_link 'Sign Up'

    user = FactoryGirl.build(:user)

    fill_in 'First name', with: user.first_name
    fill_in 'Last name', with: user.last_name
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password, match: :prefer_exact
    fill_in 'Password confirmation', with: user.password, match: :prefer_exact
    attach_file('Profile photo', 'spec/fixtures/ric_flair.jpg')
    click_button 'Sign up'

    expect(page).to have_content("Sign Out")
    expect(page).to have_content("Welcome! You have signed up successfully.")
    expect(page).to have_image user.profile_photo.url
    expect(User.last.admin).to be false
  end

  scenario 'registration info not supplied' do
    visit root_path
    click_link 'Sign Up'
    click_button 'Sign up'

    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content("Sign Out")
  end

  scenario 'password does not match confirmation' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'First name', with: 'Harold'
    fill_in 'Last name', with: 'Bendegas'
    fill_in 'Email', with: 'user@bendegas.com'
    fill_in 'Password', with: 'password', match: :prefer_exact
    fill_in 'Password confirmation', with: 'notthepassword', match: :prefer_exact
    click_button 'Sign up'

    expect(page).to have_content("doesn't match")
    expect(page).to_not have_content("Sign Out")
  end
end
