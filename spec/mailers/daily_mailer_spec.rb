# require "rails_helper"

# RSpec.describe DaylyMailer, type: :mailer do
#   describe "digest" do
#     let(:mail) { DaylyMailer.digest }

#     it "renders the headers" do
#       expect(mail.subject).to eq("Digest")
#       expect(mail.to).to eq(["to@example.org"])
#       expect(mail.from).to eq(["from@example.com"])
#     end

#     it "renders the body" do
#       expect(mail.body.encoded).to match("Hi")
#     end
#   end

# end
require "rails_helper"

RSpec.describe DailyMailer, type: :mailer do
  describe "digest" do
    let!(:user) { create(:user) }
    let!(:question) { create(:question, user: user) }
    let(:mail) { DailyMailer.digest(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("Список новых вопросов за прошлый день.")
      expect(mail.to).to eq([user.email])
    end

    it "renders the body" do
      expect(mail.body.encoded).to include(question.title)
    end
  end

end
