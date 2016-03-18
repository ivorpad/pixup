class CategoryPolicy < ApplicationPolicy

  def show?
    record.user == user 
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
