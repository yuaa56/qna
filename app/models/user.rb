class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy  
  
  validates :email, :password, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def owner_of?(obj)
    id == obj.user_id
  end
      
end
