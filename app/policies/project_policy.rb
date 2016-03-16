class ProjectPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    user.present? || record.is_public? || user.collaborator_of?(record) || record.user == user
  end

  def edit?
    update?
  end

  def update?
    user.present? && (record.user == user || user.is_admin?)
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
     scope.joins(:collaborations).where('collaborations.user_id = ?', user)
    end
  end
end
