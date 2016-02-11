class ProjectPolicy < ApplicationPolicy
  def index?
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
    user.present? && user.is_admin?
  end
end
