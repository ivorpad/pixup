class AssetPolicy < ApplicationPolicy

  def show?
    record.user == user || user.is_admin?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
