class HabitEntryPolicy < ApplicationPolicy

def new?
  user.id == record.habit.user_id
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

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end
