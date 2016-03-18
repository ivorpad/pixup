class CategoryPolicy < ApplicationPolicy

  def show?
                           # same as @project = policy_scope(Project)
                           # New instance of ProjectPolicy: user has show? permission on Project.find(project)?
                           # => true
    record.user == user || ProjectPolicy.new(user, Project.find(record.project_id)).show?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
