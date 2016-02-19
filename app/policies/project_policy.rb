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
      # Admin capabilities are handled through ActiveAdmin
      # so this scope is no longer needed.
          # return scope.all if user.has_role?(:admin) && user.present?
      scope.joins(:users).where('collaborations.user_id = ? OR projects.user_id = ?', user, user)
    end
  end
end
