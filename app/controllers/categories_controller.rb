class CategoriesController < ApplicationController
  before_action :authenticate_user!
  def index
    @categories = Categories.all
  end

  def show
    @project = Project.find(params[:project_id])
    @category = Category.find(params[:id])
  end

  def new
    @project = Project.find(params[:project_id])
    @category = Category.new
  end

  def create
    @project = Project.find(params[:project_id])

    @category = Category.new(category_params)
    @category = @project.categorizations.create(category: @category)
    @project.user_id = current_user.id

    if @category.save
      flash[:notice] = "Created"
      redirect_to project_path(@project.id)
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