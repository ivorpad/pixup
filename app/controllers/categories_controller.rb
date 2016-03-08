class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category.all
  end

  def show
    @assets = Asset.all
    @project = Project.friendly.find(params[:project_id])
    @category = Category.friendly.find(params[:id])
    @assets_content_type = Asset.pluck(:content_type).uniq
  end

  def new
    @category = Category.new
  end

  def create
    @project = Project.friendly.find(params[:project_id])
    @category = Category.new(category_params)

    if @category.save
      @category = @project.categorizations.create(category: @category)
      @project.user_id = current_user.id

      flash[:notice] = "The category has been created"
      redirect_to project_path(@project.id)
    else
      flash[:error] = "Could not be created, please try again."
      render 'new'
    end
  end

  def edit
      @project = Project.friendly.find(params[:project_id])
      @category = Category.friendly.find(params[:id])
  end

  def update
    @category = Category.friendly.find(params[:id])
    @project = Project.friendly.find(params[:project_id])

    if @category.update_attributes(category_params)

      flash[:notice] = "The category has been updated"
      redirect_to project_category_path(@project.id, @category)
    else
      flash[:error] = "Could not be updated, please try again."
      render 'edit'
    end
  end

  def destroy
  end

  private

  def category_params
    params.require(:category).permit(:name, :global)
  end
end
