#require 'rails_helper'
require_relative '../acceptance_helper'

feature "User sign out", %q{
  In order to be able to finish session
  As an user
  I want to be able to sign out
} do

  given(:user) { create(:user) }

  scenario "Sign in user try to sign out" do
    # sign_in(user.email, user.password)
    sign_in(user)
    visit root_path
    click_on "Выход"

    expect(page).to have_content "Signed out successfully"
    expect(page).to_not have_content "Выход"
    expect(page).to have_content "Войти"
    expect(page).to have_content "Регистрация"
    expect(current_path).to eq root_path
  end

end