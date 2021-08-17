class Answer < ApplicationRecord
  
    validates :question_id, :body, presence: true
    belongs_to :question, touch: true
    #, foreign_key: "question_id"
    has_many :attachments, as: :attachmentable
    accepts_nested_attributes_for :attachments, allow_destroy: true

    has_many :comments, as: :commentable
   # accepts_nested_attributes_for :comments, allow_destroy: true

    belongs_to :user
    
    default_scope { order(best: :desc, created_at: :desc) }

     after_create :new_answers_subscription


  private

   def new_answers_subscription
     NewAnswerJob.perform_later(self)
   end

end
