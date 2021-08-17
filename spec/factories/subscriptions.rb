# FactoryBot.define do
#   factory :subscription do
#     question_id { 1 }
#     user_id { 1 }
#   end
# end

FactoryBot.define do
  factory :subscription do
    user
    question
  end
end
