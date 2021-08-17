FactoryBot.define do
  factory :comment do
    strComment { "44444444" }
    commentable_id { "1" }
    commentable_type { "Question" }
    #question
    #answer
    user
  end

  factory :comment_for_answer do
    strComment { "44444444" }
    commentable_id { "1" }
    commentable_type { "Answer" }
    #question
    #answer
    user
  end

  factory :invalid_comment, class: Comment do
    strComment nil
  end

end
  
