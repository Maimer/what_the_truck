require 'rails_helper'

feature 'user signs in', %Q{
As a food truck aficionado
I want to be able to sign in to my account
} do

  scenario 'existing user enters valid login credentials' do
    user = FactoryGirl.create(:user)
    visit root_path

    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'

    expect(page).to have_content("Welcome")
    expect(page).to have_content("Sign Out")
  end

  scenario 'user enters nonexistent login credentials' do
    visit root_path

    click_link 'Sign In'
    fill_in 'Email', with: 'notanemail@nope.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'

    expect(page).to have_content('Invalid email or password')
    expect(page).to_not have_content('Welcome')
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'existing user enters incorrect password' do
    user = FactoryGirl.create(:user)

    visit root_path

    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'notthepassword'
    click_button 'Sign in'

    expect(page).to have_content('Invalid email or password')
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'authenticated user cannot re-sign in' do
    user = FactoryGirl.create(:user)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'

    expect(page).to have_content('Sign Out')
    expect(page).to_not have_content('Sign In')
  end


end
