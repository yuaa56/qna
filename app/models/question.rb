#class Question < ApplicationRecord
class Question < ActiveRecord::Base
    validates :title, :body, presence: true
    has_many :answers, dependent: :destroy

    has_many :attachments, as: :attachmentable
    accepts_nested_attributes_for :attachments, allow_destroy: true

    has_many :comments, as: :commentable
  #  accepts_nested_attributes_for :comments, allow_destroy: true

    belongs_to :user
end
