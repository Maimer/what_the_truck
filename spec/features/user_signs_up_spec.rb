require 'rails_helper'

feature 'user signs up', %Q{
As a food truck aficionado
I want to be able to create an account so that I can log in to the site
} do

# Acceptance Criteria

# I must provide my username/email and password
# I can optionally provide my first name, last name, city, and state
# I am presented with a success message if I sign in successfully
# I'm presented with errors if I provide invalid credentials

  scenario 'user inputs valid and required information' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'First name', with: 'Harold'
    fill_in 'Last name', with: 'Bendegas'
    fill_in 'Email', with: 'user@bendegas.com'
    fill_in 'Password', with: 'password', match: :prefer_exact
    fill_in 'Password confirmation', with: 'password', match: :prefer_exact
    click_button 'Sign up'

    expect(page).to have_content("Sign Out")
    expect(page).to have_content("Welcome! You have signed up successfully.")
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

  scenario 'user admin default is false' do
    user = FactoryGirl.create(:user)

    expect(user.admin).to be false
  end

  scenario 'user admin default is false' do
    user = FactoryGirl.create(:user, admin: true)

    expect(user.admin).to be true
  end
end
