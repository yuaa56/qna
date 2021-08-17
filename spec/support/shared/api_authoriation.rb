shared_examples_for "API Authenticable" do
    context "unauthorized" do
        it 'returns 401 status if there is no access_token' do
          do_request() 
          #get api_test,  params: { format: :json }
         # get '/api/v1/questions',  params: { format: :json }
         # get '/api/v1/profiles/me.json'  и это работает
          expect(response.status).to eq 401
        end
        it 'returns 401 status if access_token is invalid' do
            do_request(access_token: '1234')  
           # get api_test, params:  { format: :json, access_token: '1234' }
          expect(response.status).to eq 401
        end
    end

end