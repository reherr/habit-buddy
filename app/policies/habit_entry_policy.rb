# This file has several rubocop flags for indentation - seems like rubocop is installed but was never used
class HabitEntryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.joins(:habit).where(habits: { user_id: user.id })
    end
  end

def new?
  user == user
end

def show?
  new?
end

def create?
  new?
end

def update?
  create?
end

def edit?
  update?
end

end
