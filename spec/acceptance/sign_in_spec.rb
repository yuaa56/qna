# require 'rails_helper'
require_relative '../acceptance_helper'
# include Warden::Test::Helpers

feature 'User sign in', %q{
    In order to be able to ask question
    As an user
    I want to be able to sign in
} do 
    given(:user) { create(:user) }
    scenario 'Registered user try to sign in' do
      
      sign_in(user)

      #visit new_user_session_path
      #find('#answer_body', visible: false).set 'text answer text text'

      #fill_in 'user_email', with: user.email
      #fill_in 'user_password', with: user.password
      #save_and_open_page
      # click_on 'Войти'
      #click_on 'Log in'
  

     ## User.create!(email: 'user@test.com', password: '12345678')
    #  visit new_user_session_path
    #  fill_in 'Email', with: user.email
    #  fill_in 'Password', with: user.password
    # # fill_in 'Email', with: 'user@test.com'
    # # fill_in 'Password', with: '12345678'
    #  #save_and_open_page
    #  click_on 'Log in'
    #   save_and_open_page
      expect(page).to have_content 'Signed in successfully.'
    #  expect(page).to have_content 'Invalid Email or password.'
      expect(current_path).to eq root_path
    #  expect(current_path).to eq new_user_session_path
    end

    scenario 'Non-registered user try to sign in' do
        visit new_user_session_path
        fill_in 'Email', with: 'wrong@test.com'
        fill_in 'Password', with: '12345678'
        click_on 'Log in'
  
        expect(page).to have_content 'Invalid Email or password.'
        expect(current_path).to eq new_user_session_path
      end
end
