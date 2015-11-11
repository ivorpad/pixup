class AssetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @assets = Asset.all
  end

  def new
    @asset = Asset.new
    @project = Project.find(params[:project_id])
  end

  def create
    @project = Project.find(params[:project_id])
    @asset = @project.assets.create(asset_params)
    @asset.user_id = current_user.id

    @category = Category.find(params[:asset][:category_ids])
    @asset.category_id = params[:asset][:category_ids]
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
    @asset = Asset.find(params[:id])
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
