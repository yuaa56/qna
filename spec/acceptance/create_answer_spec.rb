require_relative '../acceptance_helper'
# /home/yuaa/qna/spec/acceptance/acceptance_helper.rb
 
feature 'Create answer', %q{
    In order to get question from community
    As authentificated user
    I want to be able to ask answers
} do 
    given(:user) { create(:user) }
    given(:question) { create(:question) }
    given(:answer) { create(:answer) }
 
  scenario 'Authenticated user creates vaild answer', js: true do
      #redirect_to question_path(@answer.question)
      sign_in(user)

      visit question_path(question)
      click_on 'Создать ответ'
      #expect(page).to have_content 'Ответ'
      #save_and_open_page

      # fill_in  'answer_body', :with => 'answer text text' 
      find('#answer_body', visible: false).set 'text answer text text'
      expect(page).to have_link 'Отмена'
      # save_and_open_page
      click_on 'Запомнить'
      visit question_path(question)
     
      expect(page).to have_content 'text answer text text'
  end

  scenario 'Authenticated user creates invaild answer', js: true  do
    sign_in(user)

    visit question_path(question)
    click_on 'Создать ответ'
    expect(page).to have_link 'Отмена'
    click_on 'Запомнить'
    # save_and_open_page
    visit question_path(question)
    expect(page).to have_content 'Your answer invalid.'
    visit question_path(question)

  end



  scenario 'Non-authenticated user tryes to create answer' do
      visit question_path(question)
      # save_and_open_page
      click_on 'Создать ответ'
      visit question_path(question)
      expect(page).to_not have_content 'text answer text text'
      # expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end

# (... ответы в файле config/locales/devise.en.yml)