require_relative '../acceptance_helper'


feature "Answer editing", %q{
  In order fix mistake
  As an author of answer
  I'd want to be able edit my answer
} do

  given!(:user) { create(:user) }
  given!(:current_user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question) }


  describe "Logged user" do
    before{ sign_in user }
    scenario "sees edit link for his answer" do
      answer.update(user: user)
      visit question_path(question)
      #within ".answers_table" do
        expect(page).to have_link "Редактировать"
      #end
    end

   # scenario "try to edit his answer" do
    scenario "try to edit his answer", js: true do
      answer.update(user: user)
      visit question_path(question)
      click_on "Редактировать"
      #  visit edit_answer_path(answer)
      
      within ".answers_edit" do
        fill_in "answer_body", with: "Test12345"
        #save_and_open_page
        click_on "Сохранить"
       
        expect(page).to_not have_content answer.body
        #expect(page).to have_content "Test12345"
        #expect(page).to_not have_selector "textarea"
      end  
    end

    scenario "not sees edit link or delete link for other user answer" do
      visit question_path(question)
      #  within ".answers_table" do
        expect(page).to_not have_link "Редактировать"
      #  expect(page).to_not have_link "Удалить"
      #end
    end
  end

  scenario "Non logged user try to edit or to delete  answer" do
    visit question_path(question)
    expect(page).to_not have_link "Редактировать"
    expect(page).to_not have_link "Удалить"
  end

end