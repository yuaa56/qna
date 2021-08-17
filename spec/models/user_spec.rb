require 'rails_helper'

 RSpec.describe User, type:  :model  do
  it {should validate_presence_of :email} 
  it {should validate_presence_of :password}
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:questions).dependent(:destroy) }
  
  let!(:users) { create_list(:user, 2) }
  let(:user) { users.first }
  let(:question) { create(:question, user: user) }
  let(:another_question) { create(:question) }


  describe "#subscribed?" do
    it { expect(user).to be_subscribed(question) }
    it { expect(user).to_not be_subscribed(another_question) }
  end

 end
