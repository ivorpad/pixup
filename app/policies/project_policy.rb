class ProjectPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    user.present?
  end

  def edit?
    update?
  end

  def update?
    user.present? && (record.user == user || user.is_collaborator? || user.is_admin?)
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def destroy?
    user.present? && ( user.is_admin? || record.user == user )
  end


  class Scope < Scope

    def resolve
      return scope.all if user.has_role?(:admin) && user.present?
      scope.where(user_id: user.id)
    end

  end
end
