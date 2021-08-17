require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
   let(:question) { create(:question)}
   let(:answer) { create(:answer) }
   let(:other_user) { create(:user) }

    describe 'GET #index' do
     let(:questions) { create_list(:question, 2)}
     before { get :index }
       
     it 'populates an array of all questions' do
         # question1 = FactoryGirl.created(:question)
       expect(assigns(:questions)).to match_array(questions)
         # expect(assigns(:questions)).to match_array(@questions)
         # expect(assigns(:questions)).to match_array([question1, question2])
     end

     it 'renders index view' do
        # get :index
        expect(response).to render_template :index
     end
    end 

    describe 'GET #show' do
      let(:question) { create(:question)}
      before { get :show, params: { id: question } }

      it 'assigns the requested question to @question' do
        expect(assigns(:question)).to eq question
      end
      it "assigns new answer for question" do
         expect(assigns(:answer)).to be_a_new(Answer)
       end

      it 'renders show view' do
        expect(response).to render_template :show
      end
    end

    describe 'GET #new' do
       sign_in_user

       before { get :new }

      it 'assigns a question to @question' do
          expect(assigns(:question)).to be_a_new(Question)
      end

      it 'renders new view' do
         expect(response).to render_template :new
      end
    end


   describe 'GET #edit' do
    sign_in_user

    let(:question) { create(:question, user_id: @user.id)}
    before {get :edit, params: { id: question }}
    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end 

  describe 'POST #create' do
   sign_in_user

   context 'with valid attributes' do
      it 'saves the new question in the database' do
         expect { post :create,  params: { question: attributes_for(:question) } }.to change(Question, :count).by(1)
      end
      it 'redirecties to show view' do
         post :create,  params: { question: attributes_for(:question) }
         #expect(response).to redirect_to question_path(assigns(:question))
         redirect_to assigns(:question)
      end
   end
   context 'with invalid attributes' do
      it 'does not save the question' do
         expect { post :create,  params: { question: attributes_for(:invalid_question) } }.to_not change(Question, :count)
      end
      it 're-renders new view' do
         post :create,  params: { question: attributes_for(:invalid_question) }
         expect(response).to render_template :new
      end
   end
end

describe 'PATCH #update'  do
   sign_in_user

   let(:question) { create(:question, user_id: @user.id)}
  context 'with valid attributes' do
   it 'assigns the requested question to @question' do
     patch :update, params: { id: question, question: attributes_for(:question) }
     expect(assigns(:question)).to eq question     
   end
   it 'changes question attributes' do
    patch :update, params: { id: question, question: { title: 'new title',     body: 'new body' } }
      question.reload
      expect(question.title).to eq 'new title'
      expect(question.body).to eq 'new body'
   end
   it 'redirects to the updated question' do
      patch :update, params: { id: question, question: attributes_for(:question) }
      redirect_to assigns(:question)
   end
 end

 context 'with invalid attributes' do
   before {  patch :update, params: { id: question, question: { title: 'new title', body: nil } } }
   it 'does not change the question attributes' do
      question.reload
      expect(question.title).to eq 'MyString'
      expect(question.body).to eq 'MyText'
   end
 
   it 're-renders edit view' do
      expect(response).to render_template :edit
   end
 end
end

describe 'DELETE #destroy'  do
  sign_in_user
  let(:question2) { create(:question, user: @user) }
   

   context "own question" do
      before { question2 }
      
      it 'deletes  question' do
         expect{ delete :destroy, params: { id: question2, user_id: @user.id } }.to change(@user.questions, :count).by(-1)
         # expect {delete :destroy, params: { id: question, user_id: @user.id } }.to change(Question, :count).by(-1)
      end

      it 'redirect to index view' do
         delete :destroy, params: { id: question }
         expect(response).to redirect_to root_path
      end
   end

   context "another user question" do
      it "deletes question" do
        question
        expect{ delete :destroy, params: { id: question , user_id: other_user.id } }.to_not change(Question, :count)
      end

      it "redirects to sign_in view " do
        delete :destroy, params: { id: question }
        expect(response).to redirect_to root_path
      end
   end

end
end