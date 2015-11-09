class AssetsController < ApplicationController
  def index
    @assets = Asset.all
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
      ## After creation, it is redirected to the project_path(:id)
      redirect_to project_path(@project.id)
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
