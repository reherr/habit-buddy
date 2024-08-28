# This file also has some rubocop flags
class HabitPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

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

end
