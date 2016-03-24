class Assets::CommentsController < CommentsController
  before_action :set_commentable
  before_action :set_project
  before_action :set_category

  private

  def set_commentable
    @commentable = Asset.friendly.find(params[:asset_id])
  end

  def set_project
    @project = Project.friendly.find(params[:project_id])
  end

  def set_category
    @category = Category.friendly.find(params[:category_id])
  end

end
