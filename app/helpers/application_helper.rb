module ApplicationHelper
  def all_categories(project)
    global = Category.where(:global => true)
    no_global = project.categories.where(:global => false)
    global.concat(no_global)
  end
end
