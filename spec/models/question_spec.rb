require 'rails_helper'

RSpec.describe Question, type:  :model do
  it {should validate_presence_of :title}
  it {should validate_presence_of :body}

  it { should have_many(:answers) }
  it { should belong_to :user }
  # it 'validates presence of title' do
  #   expect(Question.new(body: '123')).to_not be_valid
  # end
  
  # it 'validates presence of body' do
  #   expect(Question.new(title: '123')).to_not be_valid
  # end

 describe "#last_day_questions" do
  let!(:question) { create(:question) }
  let!(:question2) { create(:question, created_at: 2.days.ago) }

  it "returns the questions created later than 24 hours ago" do
    expect(Question.last_day_questions).to include(question)
  end

  it "not returns the questions created no later than 24 hours ago" do
    expect(Question.last_day_questions).to_not include(question2)
  end
 end

 describe "add subscription when create question" do
  let!(:user) { create(:user) }
  let!(:another_user) { create(:user) }

  it "for author" do
    expect{ create(:question, user: user) }.to change(user.subscriptions, :count).by(1)
  end

  it "for another user" do
    expect{ create(:question, user: user) }.to_not change(another_user.subscriptions, :count)
  end
 end
end
