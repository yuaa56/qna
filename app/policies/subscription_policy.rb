class SubscriptionPolicy < ApplicationPolicy
  def create?
    true
  end
  
  def destroy?
    true
    # user.admin? || user == record.user
  end
end
  