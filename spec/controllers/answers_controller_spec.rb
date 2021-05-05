require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
    let(:answer) { create(:answer) }
    let(:question) { create(:question) }
    # let(:question) { create(:question).find_by(id: params[:question_id]) }

    describe 'GET #show' do
    before { get :show, params: { id: answer } }
    it 'assigns the requested answer to @answer' do
      
      expect(assigns(:answer)).to eq answer
    end

    it 'renders show view' do
     
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
   before { get :new }
   it 'assigns a answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
   end

   it 'renders new view' do
      expect(response).to render_template :new
   end
  end

end
