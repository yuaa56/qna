require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
    let(:user) { create(:user) }
    let(:question) { create(:question) }
    let(:answer) { create(:answer) }
    let(:other_user) { create(:user) }

    # let(:question) { create(:question).find_by(id: params[:question_id]) }

    describe 'GET #show' do
    before { get :show, params: { id: answer, user_id: :user } }
    it 'assigns the requested answer to @answer' do
      
      expect(assigns(:answer)).to eq answer
    end

    it 'renders show view' do
     
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
   sign_in_user
   before { get :new }
   it 'assigns a answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
   end

   it 'renders new view' do
      expect(response).to render_template :new
   end
  end

  describe "DELETE #destroy" do
    sign_in_user
    let!(:answer2) { create(:answer, user: @user) }

    it "deletes own answer" do
      expect{ delete :destroy,  params: { id: answer2, format: :js } }.to change(@user.answers, :count).by(-1)
    end

    it "deletes another user answer" do
      answer
      expect{ delete :destroy,  params: { id: answer, format: :js } }.to_not change(Answer, :count)
    end
  end

end
