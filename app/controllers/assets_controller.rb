class AssetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @project = Project.friendly.find(params[:project_id])
  end

  def show
    @project = Project.friendly.find(params[:project_id])
    @category = Category.friendly.find(params[:category_id])
    @asset = @project.assets.friendly.find(params[:id])
    authorize @asset
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
      flash[:notice] = 'The asset has been created.'
      redirect_to [@project, @category, @asset]
    else
      flash[:error] = 'Please try again.'
      render 'new'
    end
  end

  def edit
    @asset = Asset.friendly.find(params[:id])
  end

  def update
    @asset = Asset.friendly.find(params[:id])

    if @asset.update_attributes(asset_params)
      flash[:notice] = 'The asset has been updated.'
      redirect_to project_asset_path
    else
      flash[:error] = 'The asset cannot be updated.'
      render 'edit'
    end
  end

  def destroy
    @asset = Asset.friendly.find(params[:id])

    if @asset.destroy
      flash[:notice] = "\"#{@asset.title}\" was deleted successfully."
      redirect_to project_assets_path
    else
      flash[:error] = 'There was an error deleting the asset.'
      render :show
    end
  end

  private

  def asset_params
    params.require(:asset).permit(:title, :asset_file, :remove_asset_file, :description, :tag_list, :category_id, category_ids: [] )
  end
end
