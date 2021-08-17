class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy  
  has_many :comments, dependent: :destroy  

  validates :email, :password, presence: true, on: :create

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_many :access_grants,
  class_name: 'Doorkeeper::AccessGrant',
  foreign_key: :resource_owner_id,
  dependent: :delete_all # or :destroy if you need callbacks
  
  has_many :access_tokens,
  class_name: 'Doorkeeper::AccessToken',
  foreign_key: :resource_owner_id,
  dependent: :delete_all # or :destroy if you need callbacks

  has_many :subscriptions, dependent: :destroy
  has_many :subscribed_questions, through: :subscriptions, source: :question


  def owner_of?(obj)
    id == obj.user_id
  end

  def subscribed?(question)
    subscriptions.where(question: question).exists?
  end
      
end
