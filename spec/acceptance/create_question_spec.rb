#require 'rails_helper'
require_relative '../acceptance_helper'

feature 'Create question', %q{
    In order to get answer from community
    As authentificated user
    I want to be able to ask questions
} do 
    given(:user) { create(:user) }
  scenario 'Authenticated user creates question' do
      sign_in(user)

   # #  User.create!(email: 'user@test.com', password: '12345678')
   #   visit new_user_session_path
   #   fill_in 'Email', with: user.email
   #   fill_in 'Password', with: user.password
   # #  fill_in 'Email', with: 'user@test.com'
   # #  fill_in 'Password', with: '12345678'
   # #  save_and_open_page
   #   click_on 'Log in'

      visit questions_path
      click_on 'Создать вопрос'
      visit new_question_path
    
      fill_in "question_title", with: 'text question'
      fill_in "question_body", with: 'text question text text'

      expect(page).to have_content 'Заголовок'
      click_on 'Запомнить'
     
      expect(page).to have_content 'text question text text'
      expect(page).to have_content 'Your question successfully created.'
    

  end
  scenario 'Non-authenticated user tryes to create question' do
      visit questions_path
      click_on 'Создать вопрос'
      expect(page).to_not have_content 'Заголовок'
      expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
# (... ответы в файле config/locales/devise.en.yml)
