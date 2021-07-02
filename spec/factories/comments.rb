FactoryBot.define do
  factory :comment do
    strComment { "" }
    commentable_id { "" }
    commentable_type { "MyString" }
  end
end
