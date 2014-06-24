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
    fill_in 'First Name', with: 'Harold'
    fill_in 'Last Name', with: 'Bendegas'
    fill_in 'Email', with: 'user@bendegas.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    click_button 'Sign Up'

    expect(page).to have_content("Sign in successful")
    expect(page).to have_content("Sign Out")
    expect(page).to have_content('Harold')
    expect(page).to have_content('Bendegas')
  end

  scenario 'registration info not supplied' do
    visit root_path
    click_link 'Sign Up'
    click_button 'Sign Up'

    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content("Sign Out")
  end

  scenario 'password does not match confirmation' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'First Name', with: 'Harold'
    fill_in 'Last Name', with: 'Bendegas'
    fill_in 'Email', with: 'user@bendegas.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password Confirmation', with: 'notthepassword'
    click_button 'Sign Up'

    expect(page).to have_content("doesn't match")
    expect(page).to_not have_content("Sign Out")
  end

end
