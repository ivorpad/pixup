class AssetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @assets = Asset.all
  end

  def new
    @asset = Asset.new
    @project = Project.friendly.find(params[:project_id])
    @project = Project.friendly.find(params[:project_id])
  end

  def create
    @project = Project.friendly.find(params[:project_id])
    @asset = @project.assets.create(asset_params)
    @asset.user_id = current_user.id

    @category = Category.friendly.find(params[:asset][:category_id])
    @asset.category_id = params[:asset][:category_id]
    @category.assets << @asset

    if @asset.save
      flash[:notice] = "Created"
      redirect_to [@project, @category, @asset]
    else
      flash[:error] = "Could not be created"
      render 'new'
    end
  end

  def show
    @project = Project.friendly.find(params[:project_id])
    @category = @project.categories.friendly.find(params[:category_id])
    @asset = @category.assets.friendly.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def asset_params
    params.require(:asset).permit(:title, :category_ids => [])
  end
end
