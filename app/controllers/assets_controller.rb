class AssetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @project = Project.friendly.find(params[:project_id])
  end

  def new
    @asset = Asset.new
    @project = Project.friendly.find(params[:project_id])
  end

  def create
    @project = Project.friendly.find(params[:project_id])
    @asset = @project.assets.create(asset_params)
    @asset.user_id = current_user.id

    category_id = params[:asset][:category_id]

    if category_id
      @category = Category.friendly.find(params[:asset][:category_id])
      @asset.category_id = params[:asset][:category_id]
      @category.assets << @asset
    end

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
    @asset = @project.assets.friendly.find(params[:id])
    @comments = Comment.all
  end

  def edit
  end

  def update
  end

  def destroy
    @asset = Asset.friendly.find(params[:id])

    if @asset.destroy
      flash[:notice] = "\"#{@asset.title}\" was deleted successfully."
      redirect_to project_assets_path
    else
      flash[:error] = "There was an error deleting the asset."
      render :show
    end

  end

  private

  def asset_params
    params.require(:asset).permit(:title, :asset_file, :category_ids => [])
  end
end
