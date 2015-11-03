class AssetsController < ApplicationController
  def index
  end

  def new
    @asset = Asset.new
  end

  def create
    @project = Project.find(params[:project_id])
    @asset = @project.assets.build(asset_params)
    @asset.user_id = current_user.id

    if @asset.save
      flash[:notice] = "Created"
      redirect_to project_assets_path
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
    params.require(:asset).permit(:title)
  end
end
