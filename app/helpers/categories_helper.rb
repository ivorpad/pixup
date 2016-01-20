module CategoriesHelper
  # scope :assets_for, -> (project, category) { where( :project_id => project.id, :category_id => category.id  ) }
  def assets_for(project, category)
    Asset.where(:project_id => project.id, :category_id => category.id)
  end
end
