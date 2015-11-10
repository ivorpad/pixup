class AssetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @assets = Asset.all
  end

  def new
    @asset = Asset.new
  end

  def create
    @project = Project.find(params[:project_id])
    # @category = Category.find(params[:category_id])
    @asset = @project.assets.create(asset_params)

    @asset.user_id = current_user.id
    # @asset.project_id = @project.id
    @asset.category_id = params[:category][:category_id]

    if @asset.save
      flash[:notice] = "Created"
      redirect_to project_category_path(@project, @category)
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
