require 'rails_helper'

feature 'the register process', js: true do
  given(:user) { FactoryGirl.create(:user) }
  before { visit '/#/sign-up' }

  scenario 'user navigates to sign up pages' do
    expect(page).to have_button('Sign Up')
  end

  scenario 'user sign up' do
    within("#sign-in-form") do
      fill_in 'user[email]', with: 'newemail@gmail.com'
      fill_in 'user[password]', with: '12345678'
      fill_in 'user[confirm_password]', with: '12345678'
    end
    click_button 'Sign Up'
    expect(page).to have_content('Logout')
    expect(page).to have_content('Add Project')
  end

end