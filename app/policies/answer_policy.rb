class AnswerPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

    def index?
      true
    end

    def show?
      true
      #scope.where(id: => record.id).exists?
    end

    def create?
      user.admin? || user == record.user
    end

    def new?
      create?
    end

    def update?
      user.admin? || user == record.user
    end 

    def edit?
      update?
    end

    def destroy?
      update?
    end

    def scope
      Pundit.policy_scope!(user, record.class)
    end
  
    class Scope
      attr_reader :user, :scope
  
      def initialize(user, scope)
        @user = user
        @scope = scope
      end
    end
   

end
