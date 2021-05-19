FactoryBot.define do
  factory :answer do
    body {"Возможно 4"}
    question 
    user
  end
  
  factory :invalid_answer, class: Answer do
    body nil
  end
end
