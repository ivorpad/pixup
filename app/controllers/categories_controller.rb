class CategoriesController < ApplicationController
  def index
    @categories = Categories.all
  end

  def show
    @category =  Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    project = Project.find(params[:project_id])
    category = Category.new(category_params)
    category = project.categorizations.create(category: category)

    if category.save
      flash[:notice] = "Created"
      byebug
      redirect_to project_path(project.id)
    else
      flash[:error] = "Could not be created"
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
