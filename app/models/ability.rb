# frozen_string_literal: true

class Ability
  include CanCan::Ability

  attr_reader :user 

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #user ||= User.new # guest user (not logged in)
    @user = user

    if user
     user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end


    def guest_abilities
      can :read, :all
    end  

    def admin_abilities
      can :manage, :all
    end

    def user_abilities
      guest_abilities
      can :create, [Question, Answer, Comment]
      can :update, [Question, Answer, Comment], user: user
    end  
end

