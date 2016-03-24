class Assets::LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_project, :find_asset, :find_category

  def create
    @asset.likes.where(user_id: current_user.id).first_or_create

    respond_to do |format|
      format.html { redirect_to [@project, @asset] }
      format.js
    end
  end

  def destroy
    @asset.likes.where(user_id: current_user.id).destroy_all

    respond_to do |format|
      format.html { redirect_to [@project, @asset] }
      format.js
    end
  end


  private

  def find_project
    @project = Project.friendly.find(params[:project_id])
  end

  def find_asset
    @asset = Asset.friendly.find(params[:asset_id])
  end

  def find_category
    @category = Category.friendly.find(params[:category_id])
  end
end
