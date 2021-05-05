class Answer < ApplicationRecord
    #include Attachable
    validates :question_id, :body, presence: true
    belongs_to :question, touch: true
    #, foreign_key: "question_id"
end
