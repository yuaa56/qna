require 'rails_helper'

describe "Profile API" do
  describe "GET/me" do
    # let(:api_test) { '/api/v1/profiles/me' }
    # let(:do_request) { get '/api/v1/profiles/me',  params: { format: :json } }

    it_behaves_like "API Authenticable"
  end

  context "authorized" do
    let(:me) { create(:user) }
    let(:access_token)  { create(:oauth_access_token, resource_owner_id: me.id) }

    before { get '/api/v1/profiles/me', params: { format: :json, access_token: access_token.token } }

    it 'returns status 200' do
        expect(response).to be_successful
    end
    
    it 'contains json' do
      expect(response.body).to be_json_eql(me.email.to_json).at_path('email')
    end

    it 'contains id' do
       expect(response.body).to be_json_eql(me.id.to_json).at_path('id')
    end
    it 'does not contain password' do
      expect(response.body).to_not have_json_path('password')
    end
    it 'does not contain encrypted password' do
      expect(response.body).to_not have_json_path('encrypted_password')
    end  
  end  

    context "unauthorized" do
      let(:me) { create(:user) }
      let(:access_token)  { create(:oauth_access_token, resource_owner_id: me.id) }
      let!(:users) { create_list(:user, 2) }
      # let!(:user1) { create(:user) }
      # let!(:user2) { create(:user) }
     
       
      before { get "/api/v1/profiles", params: { format: :json, access_token: access_token.token } }

      it "returns list of profiles" do
        expect(response.body).to have_json_size(2)
      end
      it 'returns status 200' do
        expect(response).to be_successful
      end
      #%w(id created_at updated_at email admin).each do |attr|
      #it "users object contains #{attr}" do
      # users.each do |usr|
      #  it "users object contains email" do
      #     expect(response.body).to be_json_eql(usr.email.to_json).at_path('email')
      #   end
      it "users object contains email" do
       # puts users[0].inspect
       # puts users[1].inspect
       # puts users[0].email.to_json
        
       #  puts response.body.inspect
       #s  puts response.body.to_json
       # puts response.body.class
        # puts  JSON.parse(response.body)[0]
        # puts  JSON.parse(response.body)[0]['email']
        # puts  JSON.parse(response.body)[0]['email'].to_json

        expect(JSON.parse(response.body)[0]['email'].to_json).to be_json_eql(users[0].email.to_json)

        expect(JSON.parse(response.body)[1]['email'].to_json).to be_json_eql(users[1].email.to_json)

      end
  end  
  def do_request(options = {})
    get '/api/v1/profiles/me',  params:  { format: :json }.merge(options) 
  end  
end
