require 'rails_helper'

feature 'the signin process', js: true do
  given(:user) { FactoryGirl.create(:user) }
  before { visit '/#/sign-in' }

  scenario 'user navigates to login pages' do
    expect(page).to have_button('Sign In')
  end

  scenario 'user sign in' do
    within("#sign-in-form") do
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
    end
    click_button 'Sign In'
    expect(page).to have_content('Logout')
  end

  scenario 'user navigate to login page when he is already sign in' do
    login_as user, scope: :user
    visit '/#/sign-in'
    expect(page).not_to have_button('Sign In')
    expect(page).to have_content('Logout')
  end
end