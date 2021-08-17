#class Question < ApplicationRecord
class Question < ActiveRecord::Base
    validates :title, :body, presence: true
    has_many :answers, dependent: :destroy

    has_many :attachments, as: :attachmentable
    accepts_nested_attributes_for :attachments, allow_destroy: true

    has_many :comments, as: :commentable

    has_many :subscriptions, dependent: :destroy
    has_many :subscribed_users, through: :subscriptions, source: :user

  #  accepts_nested_attributes_for :comments, allow_destroy: true

    belongs_to :user

    after_create :subscription_for_author

    scope :last_day_questions, -> { where('created_at > ?', 24.hours.ago ) }

  
    private

     def subscription_for_author
       self.subscriptions.create(user: user)
     end    
end
