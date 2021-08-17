require 'rails_helper'

RSpec.describe Answer, type: :model do
  it {should validate_presence_of :question_id}
  it {should validate_presence_of :body}

  it { should belong_to :question }
  it { should belong_to :user }

  let!(:user) { create(:user) }
  let!(:question) { create(:question) }
  let!(:answer) { create(:answer, question: question) }
  let!(:answer2) { create(:answer, question: question) }
  let!(:answer3) { build(:answer, user: user, question: question) }

  it ".new_answers_subscription" do
    expect(NewAnswerJob).to receive(:perform_later)
    answer3.save!
  end

end
