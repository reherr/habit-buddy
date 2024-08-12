class HabitPolicy < ApplicationPolicy
  def index?
    user == user
  end

  def show?
    user.id == record.user_id
  end

  def create?
    index?
  end

  def update?
    show?
  end

  def destroy?
    show?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(user: user)
    end
  end
end
