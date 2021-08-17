require 'rails_helper'

describe "Questions API" do
  let(:access_token) { create(:oauth_access_token) }
  let!(:questions) { create_list(:question, 2) }
  let!(:question) { questions.first }
  let!(:answer) { create(:answer, question: question) }
  let!(:comment) { create(:comment, commentable: question) }
  let!(:attachment) { create(:attachment, attachmentable_id: question.id, attachmentable_type: 'Question') }

  describe "GET/index" do
      #let(:api_test) { '/api/v1/questions' }
      #let(:do_request) { get '/api/v1/questions',  params: { format: :json } }

      it_behaves_like "API Authenticable"

      context "authorized" do

        before { get "/api/v1/questions", params: { format: :json, access_token: access_token.token } }
   
        it 'returns status 200' do
            expect(response).to be_successful
        end

        it "returns list of questions" do
          expect(response.body).to have_json_size(2)  #.at_path("questions")
        end
        %w(id title body created_at updated_at).each do |attr|
          it "questions object contains #{attr}" do
            #puts response.body.to_json
            #puts question.id

            expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("0/#{attr}") #at_path("questions/0/#{attr}")
          end
        end
        it "returns list of questions[0]" do
          # puts  JSON.parse(response.body)[0]
          # puts  JSON.parse(response.body)[0]['id']
          # puts  JSON.parse(response.body)[0]['id'].to_json

          expect(JSON.parse(response.body)[0]['id'].to_json).to be_json_eql(questions[0].id.to_json)
        end

        it "questions object contains short_title" do
          # puts response.body.to_json
          # puts  JSON.parse(response.body)[0]
          expect(response.body).to be_json_eql(question.title.truncate(10).to_json).at_path("0/short_title") 
        end

        context "answers" do
          it 'included in question object' do
            expect(response.body).to have_json_size(1).at_path("0/answers")
            #expect(response.body).to have_json_size(1).at_path("questions/0/answers")
          end
          %w(id body created_at updated_at).each do |attr|
            it "answers object contains #{attr}" do
              # puts response.body.to_json
              # puts question.send(attr.to_sym).to_json
              expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("0/answers/0/#{attr}")
            end
          end
          it 'included in question object111' do
            #  puts '++++++'
            #  puts response.body.to_json
            #  puts '*****'
            #  puts  JSON.parse(response.body)[0]['answers'][0]
            #  puts '//////'
            #  puts questions[0].answers[0].to_json            
            # puts questions[0].answers[0].id.to_json
            # puts JSON.parse(response.body)[0]['answers'][0]['id'].to_json
           expect(JSON.parse(response.body)[0]['answers'][0]['id'].to_json).to be_json_eql(questions[0].answers[0].id.to_json)
          end
        end 
      end  
      def do_request(options = {})
        get '/api/v1/questions',  params: { format: :json }.merge(options)  
      end  
  end
end